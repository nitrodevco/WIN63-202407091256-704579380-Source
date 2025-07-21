package com.sulake.habbo.messenger {
    import com.sulake.core.runtime.IDisposable
    import com.sulake.core.utils.ErrorReportStorage
    import com.sulake.core.window.IWindow
    import com.sulake.core.window.IWindowContainer
    import com.sulake.core.window.components.IItemListWindow
    import com.sulake.core.window.components.IRegionWindow
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow
    import com.sulake.core.window.components.IWidgetWindow
    import com.sulake.core.window.events.WindowEvent
    import com.sulake.habbo.communication.messages.outgoing.friendlist.class_317
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetMessengerHistoryComposer
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_201
    import com.sulake.habbo.communication.messages.outgoing.users.class_322
    import com.sulake.habbo.friendlist.IFriend
    import com.sulake.habbo.window.widgets.IIlluminaChatBubbleWidget
    import com.sulake.habbo.window.widgets.IIlluminaInputHandler
    import com.sulake.habbo.window.widgets.IIlluminaInputWidget
    import com.sulake.habbo.window.widgets.IAvatarImageWidget
    import com.sulake.habbo.window.widgets.IBadgeImageWidget

    import flash.utils.Dictionary
    import flash.utils.getTimer

    public class MainView implements IDisposable, IIlluminaInputHandler {

        private static const HIDDEN: String = "HIDDEN";

        private static const NO_CONVERSATION: int = -1;

        private static const NOTIFICATION_ICON_WIDTH: int = 55;

        private static const SCROLL_TRIGGER_HEIGHT: int = 150;

        private static const COMBINE_MESSAGING_THRESHOLD: int = 600000;

        private static const CHAT_ITEM_RENDER_MAX_BUNDLE_SIZE: int = 3;

        private static const CHAT_ITEM_RENDER_MAX_MESSAGES_SIZE: int = 7;

        private static const CHAT_ITEM_INITIAL_MULTIPLIER: int = 3;

        private static const const_1146: int = 40;

        private static const const_1052: int = 4000;

        private static const ERROR_MESSAGES: Dictionary = new Dictionary();

        {
            ERROR_MESSAGES[3] = "${messenger.error.receivermuted}";
            ERROR_MESSAGES[4] = "${messenger.error.sendermuted}";
            ERROR_MESSAGES[5] = "${messenger.error.offline}";
            ERROR_MESSAGES[6] = "${messenger.error.notfriend}";
            ERROR_MESSAGES[7] = "${messenger.error.busy}";
            ERROR_MESSAGES[8] = "${messenger.error.receiverhasnochat}";
            ERROR_MESSAGES[9] = "${messenger.error.senderhasnochat}";
            ERROR_MESSAGES[10] = "${messenger.error.offline_failed}";
            ERROR_MESSAGES[11] = "${messenger.error.not_group_member}";
            ERROR_MESSAGES[12] = "${messenger.error.not_group_admin}";
            ERROR_MESSAGES[13] = "${messenger.error.sender_im_unavailable}";
            ERROR_MESSAGES[14] = "${messenger.error.recipient_im_unavailable}";
        }

        private var _messenger: HabboMessenger;

        private var _frame: IWindowContainer;

        private var _conversationList: IItemListWindow;

        private var _avatarList: IWindowContainer;

        private var _avatarScrollIndex: int;

        private var _avatarListOverflow: Boolean;

        private var _conversationHistory: Dictionary;

        private var _currentConversationId: int = -1;

        private var _avatarTemplate: IWindowContainer;

        private var _chatItemTemplate: IWidgetWindow;

        private var _notificationItemTemplate: IWindowContainer;

        private var _invitationItemTemplate: IWindowContainer;

        private var _infoItemTemplate: IWindowContainer;

        private var _isConversationLoading: Boolean;

        private var _isModerationInfoRecorded: Boolean = false;

        private var _messageCounter: int = 1;

        private var _pendingMessages: Dictionary;

        private var _conversationHistoryIndex: int;

        private var _historyFetchesTimestamps: Dictionary;

        private var _confirmedMessageIds: Dictionary;

        public function MainView(param1: HabboMessenger) {
            super();
            _conversationHistory = new Dictionary();
            _pendingMessages = new Dictionary();
            _historyFetchesTimestamps = new Dictionary();
            _confirmedMessageIds = new Dictionary();
            _messenger = param1;
            _frame = _messenger.getXmlWindow("messenger") as IWindowContainer;
            _frame.visible = false;
            _frame.procedure = messengerWindowProcedure;
            IStaticBitmapWrapperWindow(_frame.findChildByName("header_button_image")).assetUri = "messenger_minimize_button";
            _avatarList = _frame.findChildByName("avatar_list") as IWindowContainer;
            _avatarTemplate = _avatarList.getChildAt(0) as IWindowContainer;
            _avatarList.removeChild(_avatarTemplate);
            _avatarScrollIndex = 0;
            _conversationList = _frame.findChildByName("conversation") as IItemListWindow;
            _chatItemTemplate = _conversationList.getListItemByName("msg_normal") as IWidgetWindow;
            _notificationItemTemplate = _conversationList.getListItemByName("msg_notification") as IWindowContainer;
            _invitationItemTemplate = _conversationList.getListItemByName("msg_invitation") as IWindowContainer;
            _infoItemTemplate = _conversationList.getListItemByName("msg_info") as IWindowContainer;
            _conversationList.removeListItems();
            _conversationHistoryIndex = -1;
            IIlluminaInputWidget(IWidgetWindow(_frame.findChildByName("input_widget")).widget).submitHandler = this;
        }

        private static function avatarVisible(param1: IWindow): Boolean {
            return param1 != null && param1.tags.indexOf("HIDDEN") < 0;
        }

        private static function setAvatarVisibilityTag(param1: IWindow, param2: Boolean): void {
            if (param1 == null) {
                return;
            }
            var _loc3_: Boolean = avatarVisible(param1);
            if (_loc3_ && !param2) {
                param1.tags.push("HIDDEN");
            } else if (!_loc3_ && param2) {
                param1.tags.splice(param1.tags.indexOf("HIDDEN"), 1);
            }
        }

        private static function escapeExternalKeys(param1: String): String {
            if (param1.search("\\${") == 0) {
                return " " + param1;
            }
            return param1;
        }

        public function dispose(): void {
            if (!disposed) {
                _conversationList = null;
                _avatarList = null;
                if (_frame != null) {
                    _frame.dispose();
                    _frame = null;
                }
                if (_chatItemTemplate != null) {
                    _chatItemTemplate.dispose();
                    _chatItemTemplate = null;
                }
                if (_notificationItemTemplate != null) {
                    _notificationItemTemplate.dispose();
                    _notificationItemTemplate = null;
                }
                if (_invitationItemTemplate != null) {
                    _invitationItemTemplate.dispose();
                    _invitationItemTemplate = null;
                }
                if (_infoItemTemplate != null) {
                    _infoItemTemplate.dispose();
                    _infoItemTemplate = null;
                }
                if (_avatarTemplate != null) {
                    _avatarTemplate.dispose();
                    _avatarTemplate = null;
                }
                _conversationHistory = null;
                _messenger = null;
                _pendingMessages = null;
                _historyFetchesTimestamps = null;
                _confirmedMessageIds = null;
            }
        }

        public function get disposed(): Boolean {
            return _messenger == null;
        }

        public function get isOpen(): Boolean {
            return _frame != null && Boolean(_frame.visible);
        }

        public function toggle(): void {
            if (isOpen) {
                hide();
            } else {
                show();
            }
        }

        public function show(param1: Boolean = false): void {
            if (param1 || visibleAvatarCount > 0) {
                _frame.visible = true;
                _frame.activate();
            }
            if (_currentConversationId != -1) {
                setChatIndicatorVisibility(_currentConversationId, false);
            }
        }

        public function hide(): void {
            _frame.visible = false;
        }

        public function startConversation(friendId: int, openConversation: Boolean = true, chatEntry: ChatEntry = null): void {
            if (!(friendId in _conversationHistory)) {
                _conversationHistory[friendId] = [];

                if (!_isModerationInfoRecorded) {
                    recordNotificationMessage(friendId, "${messenger.moderationinfo}");
                    _isModerationInfoRecorded = true;
                }

                var friend: IFriend = _messenger.getFriend(friendId, chatEntry);
                if (!friend) {
                    ErrorReportStorage.addDebugData("Messenger Mainview", "User got start conversation request from nonexistent friend, id: " + friendId);
                    return;
                }

                if (!friend.online) {
                    recordNotificationMessage(friendId, "${messenger.notification.persisted_messages}");
                }

                var avatarContainer: IWindowContainer = _avatarTemplate.clone() as IWindowContainer;
                setAvatarVisibilityTag(avatarContainer, true);
                avatarContainer.blend = 0;
                avatarContainer.id = friendId;
                if (friendId < 0) {
                    avatarContainer.name = String(friendId);
                }

                var avatarImageWidgetWindow: IWidgetWindow = avatarContainer.findChildByName("avatar_image") as IWidgetWindow;
                var badgeImageWidgetWindow: IWidgetWindow = avatarContainer.findChildByName("group_badge_image") as IWidgetWindow;

                if (friend.id > 0) {
                    var avatarImageWidget: IAvatarImageWidget = avatarImageWidgetWindow.widget as IAvatarImageWidget;
                    avatarImageWidget.figure = friend.figure;
                    badgeImageWidgetWindow.visible = false;
                    avatarImageWidgetWindow.visible = true;
                } else {
                    var badgeImageWidget: IBadgeImageWidget = badgeImageWidgetWindow.widget as IBadgeImageWidget;
                    badgeImageWidget.badgeId = friend.figure;
                    badgeImageWidget.groupId = friend.id;
                    badgeImageWidgetWindow.visible = true;
                    avatarImageWidgetWindow.visible = false;
                }

                var avatarClickRegion: IRegionWindow = avatarContainer.findChildByName("avatar_click_region") as IRegionWindow;
                avatarClickRegion.toolTipCaption = friend.name;
                _avatarList.addChild(avatarContainer);
                refreshAvatarList();
            }

            if (openConversation || !isOpen) {
                selectConversation(friendId);
            }

            refreshChatCount(openConversation);
        }

        public function addConsoleMessage(param1: int, param2: String, param3: int, param4: String, param5: int, param6: int, param7: String, param8: String): void {
            if (param5 > 0) {
                onConfirmOwnChatMessage(param4, param2, param5);
            } else {
                recordChatMessage(param1, param2, true, param3, param6, param7, param8, param4);
            }
        }

        public function addRoomInvite(param1: int, param2: String): void {
            recordInvitationMessage(param1, _messenger.getText("messenger.invitation") + " " + param2, true);
        }

        public function setFollowingAllowed(param1: int, param2: Boolean): void {
            if (param1 == _currentConversationId) {
                refreshButtons();
            }
        }

        public function onInstantMessageError(param1: int, param2: int, param3: String): void {
            var _loc5_: String = null;
            var _loc4_: RegExp = null;
            if (param2 in ERROR_MESSAGES) {
                if (param3.length > 0) {
                    _loc5_ = String(ERROR_MESSAGES[param2]);
                    _loc4_ = /[${}]/g;
                    _loc5_ = _loc5_.replace(_loc4_, "");
                    recordNotificationMessage(param1, _messenger.getText(_loc5_) + ": " + param3);
                } else {
                    recordNotificationMessage(param1, ERROR_MESSAGES[param2]);
                }
            }
        }

        public function setOnlineStatus(param1: int, param2: Boolean): void {
            if (param1 in _conversationHistory) {
                recordInfoMessage(param1, param2 ? "${messenger.notification.online}" : "${messenger.notification.offline}");
            }
        }

        private function selectConversation(param1: int): void {
            _currentConversationId = param1;
            setAvatarVisibilityTag(getAvatarWrapper(param1), true);
            setChatIndicatorVisibility(param1, false);
            refreshConversationList();
            refreshAvatarList();
            var _loc3_: IFriend = _messenger.getFriend(_currentConversationId);
            var _loc2_: String = _loc3_ != null ? _loc3_.name : "";
            _frame.findChildByName("separator_label").visible = _currentConversationId < 0 || _loc3_ != null;
            _messenger.localization.registerParameter("messenger.window.separator", "friend_name", _loc2_);
            _messenger.localization.registerParameter("messenger.window.input.default", "friend_name", _loc2_);
            _frame.invalidate();
        }

        public function hideConversation(param1: int): void {
            var _loc2_: IWindow = getAvatarWrapper(param1);
            if (_loc2_ != null) {
                setAvatarVisibilityTag(_loc2_, false);
            }
            if (visibleAvatarCount == 0) {
                selectConversation(-1);
                hide();
            } else {
                for each(_loc2_ in _avatarList.iterator) {
                    if (avatarVisible(_loc2_)) {
                        _avatarScrollIndex = 0;
                        selectConversation(_loc2_.id);
                        break;
                    }
                }
            }
            refreshChatCount();
        }

        private function refreshChatCount(param1: Boolean = false): void {
            _messenger.localization.registerParameter("messenger.window.title", "open_chat_count", visibleAvatarCount.toString());
            _messenger.conversationCountUpdated(visibleAvatarCount, hasUnreadChat && !param1);
        }

        private function recordChatMessage(chatId: int, message: String, isOwnChat: Boolean, seconds: int, senderId: int, senderName: String, senderFigure: String, messageId: String = "", awaitConfirmationId: int = 0): void {
            var chatEntry: ChatEntry;
            if (isOwnChat) {
                chatEntry = new ChatEntry(ChatEntry.TYPE_OWN_CHAT, chatId, message, seconds, senderId, senderName, senderFigure, messageId);
                recordChatEntry(chatId, chatEntry, true);
            } else {
                chatEntry = new ChatEntry(ChatEntry.TYPE_OTHER_CHAT, chatId, message, seconds, senderId, senderName, senderFigure, messageId, awaitConfirmationId);
                if (awaitConfirmationId > 0) {
                    _pendingMessages[awaitConfirmationId] = chatEntry;
                }
                recordChatEntry(chatId, chatEntry);
            }
        }

        private function onConfirmOwnChatMessage(param1: String, param2: String, param3: int): void {
            var _loc4_: int = 0;
            var _loc8_: Boolean = false;
            var _loc7_: int = 0;
            var _loc10_: IWidgetWindow = null;
            var _loc6_: IIlluminaChatBubbleWidget = null;
            var _loc9_: int = 0;
            var _loc5_: ChatEntry;
            if ((_loc5_ = _pendingMessages[param3]) != null) {
                _loc5_.isConfirmed(param2, param1);
                _confirmedMessageIds[param1] = true;
                _loc4_ = _conversationList.numListItems;
                _loc8_ = false;
                _loc7_ = 0;
                while (_loc7_ < _loc4_ && !_loc8_) {
                    if ((_loc10_ = _conversationList.getListItemAt(_loc7_) as IWidgetWindow) != null) {
                        if ((_loc6_ = _loc10_.widget as IIlluminaChatBubbleWidget) != null) {
                            _loc9_ = 0;
                            while (_loc9_ < _loc6_.numMessages) {
                                if (_loc6_.getAwaitingConfirmationId(_loc9_) == param3) {
                                    _loc6_.clearAwaitingConfirmationId(_loc9_);
                                    _loc6_.setMessage(_loc9_, param2);
                                    _loc8_ = true;
                                    break;
                                }
                                _loc9_ += 1;
                            }
                        }
                    }
                    _loc7_ += 1;
                }
                delete _pendingMessages[param3];
            }
        }

        private function recordNotificationMessage(param1: int, param2: String): void {
            recordChatEntry(param1, new ChatEntry(3, 0, param2, 0));
        }

        private function recordInfoMessage(param1: int, param2: String, param3: Boolean = false): void {
            recordChatEntry(param1, new ChatEntry(4, 0, param2, 0), param3);
        }

        private function recordInvitationMessage(param1: int, param2: String, param3: Boolean = false): void {
            recordChatEntry(param1, new ChatEntry(5, 0, param2, 0), param3);
        }

        private function recordChatEntry(param1: int, param2: ChatEntry, param3: Boolean = false): void {
            if (_messenger == null) {
                return;
            }
            if (param2.messageId != "") {
                if (param2.messageId in _confirmedMessageIds) {
                    return;
                }
                _confirmedMessageIds[param2.messageId] = true;
            }
            if (!(param1 in _conversationHistory)) {
                if (param1 <= 0) {
                    return;
                }
                startConversation(param1, false, param2.type == 2 ? param2 : null);
            }
            var _loc5_: Array;
            var _loc6_: ChatEntry = (_loc5_ = _conversationHistory[param1]).length > 0 ? _loc5_[_loc5_.length - 1] : null;
            _loc5_.push(param2);
            var _loc4_: IWindowContainer;
            if ((_loc4_ = getAvatarWrapper(param1)) != null) {
                setAvatarVisibilityTag(_loc4_, true);
                refreshAvatarList();
            }
            if (param1 == _currentConversationId) {
                addToConversationAndCombine(param2, _loc6_);
                _conversationList.arrangeListItems();
                _conversationList.scrollV = 1;
                if (!isOpen && param3) {
                    setChatIndicatorVisibility(param1, true);
                }
            } else {
                if (param3) {
                    setChatIndicatorVisibility(param1, true);
                }
                if (visibleAvatarCount == 1) {
                    selectConversation(param1);
                }
            }
            refreshChatCount();
        }

        private function shouldCombineWithPreviousEntry(param1: int, param2: ChatEntry, param3: ChatEntry): Boolean {
            var _loc4_: Boolean = false;
            var _loc5_: Boolean = false;
            var _loc6_: Array;
            if ((_loc6_ = _conversationHistory[param1]).length > 0) {
                param3.sentTimeStamp();
                if (param1 > 0) {
                    if (param2.type == param3.type && (param2.type == 1 || param2.type == 2) && param2.sentTimeStamp() < param3.sentTimeStamp() + 600000) {
                        _loc5_ = true;
                    }
                } else {
                    _loc4_ = param2.type == 2 && param3.senderId == param2.senderId;
                    if (param2.type == param3.type && (param2.type == 1 || _loc4_) && param2.sentTimeStamp() < param3.sentTimeStamp() + 600000) {
                        _loc5_ = true;
                    }
                }
            }
            return _loc5_;
        }

        private function getAvatarWrapper(param1: int): IWindowContainer {
            return _avatarList.getChildByID(param1) as IWindowContainer;
        }

        private function setChatIndicatorVisibility(param1: int, param2: Boolean): void {
            var _loc3_: IWindowContainer = getAvatarWrapper(param1);
            if (_loc3_ != null) {
                _loc3_.findChildByName("chat_indicator").visible = param2;
            }
        }

        private function createChatItem(param1: ChatEntry, param2: Boolean = false): IWindow {
            var _loc9_: IWidgetWindow = null;
            var _loc5_: IIlluminaChatBubbleWidget = null;
            var _loc11_: IWindowContainer = null;
            var _loc10_: IWindow = null;
            var _loc4_: IWindowContainer = null;
            var _loc6_: IWindowContainer = null;
            var _loc3_: * = false;
            var _loc7_: IFriend = null;
            switch (param1.type - 1) {
                case 0:
                    (_loc9_ = _chatItemTemplate.clone() as IWidgetWindow).width = conversationItemWidth;
                    (_loc5_ = _loc9_.widget as IIlluminaChatBubbleWidget).appendMessage(param1.message, false, param1.awaitConfirmationId);
                    _loc5_.timeStamp = param1.sentTimeStamp();
                    _loc5_.flipped = false;
                    _loc5_.figure = _messenger.sessionDataManager.figure;
                    _loc5_.userName = _messenger.sessionDataManager.userName;
                    _loc7_ = _messenger.getFriend(_currentConversationId);
                    if (!param2 && _loc7_ != null && !_loc7_.online && (_loc7_.persistedMessageUser || _loc7_.pocketHabboUser)) {
                        _loc5_.friendOnlineStatus = false;
                    }
                    return _loc9_;
                case 1:
                    (_loc9_ = _chatItemTemplate.clone() as IWidgetWindow).width = conversationItemWidth;
                    (_loc5_ = _loc9_.widget as IIlluminaChatBubbleWidget).appendMessage(param1.message);
                    _loc5_.timeStamp = param1.sentTimeStamp();
                    _loc5_.flipped = true;
                    for each(var _loc8_ in _avatarList.iterator) {
                        _loc3_ = _loc8_ != null && _loc8_.id == _currentConversationId;
                        if (!_loc3_ && _loc8_ != null && _currentConversationId < 0) {
                            _loc3_ = Number(_loc8_.name) == _currentConversationId;
                        }
                        if (_loc3_) {
                            _loc5_.figure = param1.senderFigure;
                            _loc5_.userId = param1.senderId;
                            _loc5_.userName = param1.senderName;
                            break;
                        }
                    }
                    return _loc9_;
                case 2:
                    (_loc4_ = _notificationItemTemplate.clone() as IWindowContainer).findChildByName("content").width = conversationItemWidth - 55;
                    _loc4_.findChildByName("content").caption = param1.message;
                    return _loc4_;
                case 3:
                    (_loc10_ = (_loc11_ = _infoItemTemplate.clone() as IWindowContainer).findChildByName("content")).limits.minWidth = conversationItemWidth;
                    _loc10_.limits.maxWidth = conversationItemWidth;
                    _loc10_.caption = param1.message;
                    return _loc11_;
                case 4:
                    (_loc6_ = _invitationItemTemplate.clone() as IWindowContainer).findChildByName("content").width = conversationItemWidth - 55;
                    _loc6_.findChildByName("content").caption = param1.message;
                    return _loc6_;
                default:
                    return null;
            }
        }

        private function appendChatEntry(param1: ChatEntry): IWindow {
            var _loc2_: IWindow = createChatItem(param1);
            _conversationList.addListItem(_loc2_);
            return _loc2_;
        }

        private function adjustListItemWidths(): void {
            var _loc1_: int = 0;
            var _loc2_: IWindow = null;
            var _loc3_: IWindow = null;
            _loc1_ = 0;
            while (_loc1_ < _conversationList.numListItems) {
                _loc2_ = _conversationList.getListItemAt(_loc1_);
                switch (_loc2_.name) {
                    case "msg_normal":
                        break;
                    case "msg_notification":
                        IWindowContainer(_loc2_).findChildByName("content").width = conversationItemWidth - 55;
                        break;
                    case "msg_info":
                        _loc3_ = IWindowContainer(_loc2_).findChildByName("content");
                        _loc3_.limits.minWidth = conversationItemWidth;
                        _loc3_.limits.maxWidth = conversationItemWidth;
                }
                _loc2_.width = conversationItemWidth;
                _loc1_++;
            }
            _conversationList.arrangeListItems();
            _frame.invalidate();
        }

        private function get conversationItemWidth(): int {
            return _frame.width - 27;
        }

        private function refreshButtons(): void {
            IItemListWindow(_frame.findChildByName("button_strip")).arrangeListItems();
        }

        public function loadMessageHistory(param1: int, param2: Array): void {
            var _loc6_: ChatEntry = null;
            var _loc4_: Array = [];
            var _loc3_: int = _messenger.sessionDataManager.userId;
            for each(var _loc5_ in param2) {
                if (!(_loc5_.messageId in _confirmedMessageIds)) {
                    _loc6_ = new ChatEntry(_loc5_.senderId == _loc3_ ? 1 : 2, param1, _loc5_.message, _loc5_.secondsSinceSent, _loc5_.senderId, _loc5_.senderName, _loc5_.senderFigure, _loc5_.messageId);
                    _loc4_.push(_loc6_);
                }
            }
            if (_loc4_.length == 0) {
                return;
            }
            var _loc7_: Array;
            if ((_loc7_ = _conversationHistory[param1]) == null) {
                _loc7_ = [];
                _conversationHistory[param1] = _loc7_;
            }
            _conversationHistory[param1] = _loc4_.concat(_loc7_);
            if (param1 == _currentConversationId) {
                if (_conversationHistoryIndex != -1) {
                    _conversationHistoryIndex += _loc4_.length;
                }
                addMissingChatEntries();
            }
        }

        private function requestHistory(param1: int): void {
            var _loc4_: Object = null;
            var _loc2_: Array = _conversationHistory[param1];
            if (_loc2_ == null) {
                return;
            }
            var _loc5_: String = "";
            if (_loc2_.length > 0) {
                _loc5_ = String(_loc2_[0].messageId);
            }
            var _loc3_: int = getTimer();
            if (param1 in _historyFetchesTimestamps) {
                if ((_loc4_ = _historyFetchesTimestamps[param1]).messageId == _loc5_ && _loc4_.time + 4000 > _loc3_) {
                    return;
                }
            }
            _historyFetchesTimestamps[param1] = {
                "messageId":_loc5_,
                "time":_loc3_
            };
            _messenger.send(new GetMessengerHistoryComposer(param1, _loc5_));
        }

        private function refreshConversationList(): void {
            _isConversationLoading = true;
            _conversationList.destroyListItems();
            _conversationHistoryIndex = -1;
            scrollBack(true);
            _conversationList.arrangeListItems();
            _conversationList.scrollV = 1;
            _isConversationLoading = false;
        }

        private function addToConversationAndCombine(param1: ChatEntry, param2: ChatEntry, param3: Boolean = false): Boolean {
            var _loc5_: int = 0;
            var _loc7_: IWidgetWindow = null;
            var _loc4_: IIlluminaChatBubbleWidget = null;
            var _loc6_: Boolean = false;
            if (param2 != null && shouldCombineWithPreviousEntry(_currentConversationId, param1, param2)) {
                if ((_loc5_ = param3 ? 0 : _conversationList.numListItems - 1) >= 0) {
                    if ((_loc7_ = _conversationList.getListItemAt(_loc5_) as IWidgetWindow) != null) {
                        if ((_loc4_ = _loc7_.widget as IIlluminaChatBubbleWidget) != null) {
                            _loc4_.appendMessage(param1.message, param3, param1.awaitConfirmationId);
                            if (!param3) {
                                _loc4_.timeStamp = param1.sentTimeStamp();
                            }
                            _loc6_ = true;
                        }
                    }
                }
            }
            if (!_loc6_) {
                if (param3) {
                    _conversationList.addListItemAt(createChatItem(param1, true), 0);
                } else {
                    appendChatEntry(param1);
                }
            }
            return _loc6_;
        }

        private function addMissingChatEntries(): void {
            if (-_conversationList.scrollableRegion.y > 150) {
                return;
            }
            _isConversationLoading = true;
            var _loc1_: Number = Number(_conversationList.scrollV);
            var _loc2_: int = int(_conversationList.scrollableRegion.height);
            scrollBack();
            _conversationList.arrangeListItems();
            _conversationList.scrollV = 1 - _loc2_ * (1 - _loc1_) / _conversationList.scrollableRegion.height;
            _isConversationLoading = false;
        }

        private function scrollBack(param1: Boolean = false): void {
            var _loc7_: int = 0;
            var _loc4_: ChatEntry = null;
            var _loc2_: Array = _conversationHistory[_currentConversationId];
            if (_loc2_ == null) {
                requestHistory(_currentConversationId);
                return;
            }
            var _loc10_: int = int(_conversationHistoryIndex == -1 ? _loc2_.length : _conversationHistoryIndex);
            var _loc3_: int = int(param1 ? 3 : 1);
            var _loc8_: int = 0;
            var _loc9_: Boolean = false;
            var _loc6_: int = 0;
            var _loc5_: * = _conversationHistoryIndex == -1 ? null : _loc2_[_conversationHistoryIndex];
            _loc7_ = _loc10_ - 1;
            while (_loc7_ >= 0) {
                _loc4_ = _loc2_[_loc7_];
                if (_loc9_ && !shouldCombineWithPreviousEntry(_currentConversationId, _loc4_, _loc5_)) {
                    break;
                }
                if (!addToConversationAndCombine(_loc4_, _loc5_, true)) {
                    _loc8_ += 1;
                }
                _loc5_ = _loc4_;
                _loc6_ += 1;
                _conversationHistoryIndex = _loc7_;
                if (_loc8_ >= 3 * _loc3_) {
                    _loc9_ = true;
                }
                if (_loc6_ >= 7 * _loc3_) {
                    break;
                }
                _loc7_--;
            }
            if (_conversationHistoryIndex < 40) {
                requestHistory(_currentConversationId);
            }
        }

        private function refreshAvatarList(): void {
            var _loc1_: * = false;
            var _loc2_: Boolean = false;
            var _loc3_: int = 0;
            var _loc5_: int = 0;
            _avatarListOverflow = false;
            for each(var _loc4_ in _avatarList.iterator) {
                _loc1_ = _loc4_.id == _currentConversationId;
                if (!_loc1_ && _loc4_.name.length > 0) {
                    _loc1_ = Number(_loc4_.name) == _currentConversationId;
                }
                if (_loc1_) {
                    setAvatarVisibilityTag(_loc4_, true);
                }
                _loc2_ = avatarVisible(_loc4_);
                if (_loc5_ < _avatarScrollIndex || !_loc2_ || _avatarListOverflow) {
                    _loc4_.visible = false;
                } else if (_loc3_ + _loc4_.width > _avatarList.width) {
                    _loc4_.visible = false;
                    _avatarListOverflow = true;
                } else {
                    _loc4_.visible = true;
                    _loc4_.blend = _loc1_ ? 1 : 0;
                    _loc4_.x = _loc3_;
                    _loc3_ += _loc4_.width;
                }
                if (_loc2_) {
                    _loc5_++;
                }
            }
            _frame.findChildByName("avatars_scroll_left").visible = _avatarScrollIndex > 0;
            _frame.findChildByName("avatars_scroll_right").visible = _avatarListOverflow;
        }

        private function get visibleAvatarCount(): int {
            var _loc1_: int = 0;
            for each(var _loc2_ in _avatarList.iterator) {
                if (avatarVisible(_loc2_)) {
                    _loc1_++;
                }
            }
            return _loc1_;
        }

        private function get hasUnreadChat(): Boolean {
            var _loc1_: IWindowContainer = null;
            for each(var _loc2_ in _avatarList.iterator) {
                if (avatarVisible(_loc2_)) {
                    _loc1_ = IWindowContainer(_loc2_);
                    if (_loc1_ != null) {
                        if (_loc1_.findChildByName("chat_indicator").visible) {
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        private function messengerWindowProcedure(param1: WindowEvent, param2: IWindow): void {
            switch (param1.type) {
                case "WE_RESIZE":
                    if (param2 == _frame) {
                        adjustListItemWidths();
                        refreshAvatarList();
                    }
                    break;
                case "WE_RELOCATED":
                    if (param2.name == "_CONTAINER" && !_isConversationLoading) {
                        addMissingChatEntries();
                    }
                    break;
                case "WME_CLICK":
                    switch (param2.name) {
                        case "avatar_click_region":
                            selectConversation(param2.parent.id);
                            break;
                        case "avatars_scroll_left":
                            if (_avatarScrollIndex > 0) {
                                _avatarScrollIndex--;
                                refreshAvatarList();
                            }
                            break;
                        case "avatars_scroll_right":
                            if (_avatarListOverflow) {
                                _avatarScrollIndex++;
                                refreshAvatarList();
                            }
                            break;
                        case "close_conversation_button":
                            hideConversation(_currentConversationId);
                            break;
                        case "follow_button":
                            if (_currentConversationId > 0) {
                                _messenger.send(new FollowFriendMessageComposer(_currentConversationId));
                                _messenger.send(new EventLogMessageComposer("Navigation", "IM", "go.im"));
                            } else {
                                _messenger.followingToGroupRoom = true;
                                _messenger.send(new class_201(Math.abs(_currentConversationId), false));
                            }
                            break;
                        case "profile_button":
                            if (_currentConversationId > 0) {
                                _messenger.send(new class_322(_currentConversationId));
                                _messenger.trackGoogle("extendedProfile", "messenger_conversation");
                            } else {
                                _messenger.send(new class_201(Math.abs(_currentConversationId), true));
                                _messenger.trackGoogle("extendedProfile", "messenger_conversation");
                            }
                            break;
                        case "report_button":
                            _messenger.reportUser(_currentConversationId);
                            break;
                        case "header_button_close":
                            hide();
                    }
            }
        }

        public function onInput(param1: IWidgetWindow, param2: String): void {
            if (param2 == "") {
                return;
            }
            var _loc5_: int = _messageCounter;
            _messageCounter += 1;
            _messenger.send(new class_317(_currentConversationId, param2, _loc5_));
            IIlluminaInputWidget(param1.widget).message = "";
            var _loc3_: Array = _conversationHistory[_currentConversationId];
            if (_loc3_.length == 0 || _loc3_.length == 1 && ChatEntry(_loc3_[0]).type == 3) {
                _messenger.playSendSound();
            }
            var _loc4_: String = _messenger.sessionDataManager.figure;
            var _loc6_: String = _messenger.sessionDataManager.userName;
            var _loc7_: int = _messenger.sessionDataManager.userId;
            recordChatMessage(_currentConversationId, escapeExternalKeys(param2), false, 0, _loc7_, _loc6_, _loc4_, "", _loc5_);
        }
    }
}
