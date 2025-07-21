package com.sulake.habbo.messenger {
    import assets.class_14

    import com.sulake.core.assets.IAsset
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.assets.XmlAsset
    import com.sulake.core.communication.messages.IMessageComposer
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.runtime.Component
    import com.sulake.core.runtime.ComponentDependency
    import com.sulake.core.runtime.IContext
    import com.sulake.core.window.IWindow
    import com.sulake.habbo.communication.IHabboCommunicationManager
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_307
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.ConsoleMessageHistoryEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_756
    import com.sulake.habbo.communication.messages.incoming.preferences.class_219
    import com.sulake.habbo.communication.messages.incoming.users.class_835
    import com.sulake.habbo.communication.messages.outgoing.room.session.class_974
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1187
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1288
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1375
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1378
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1500
    import com.sulake.habbo.friendlist.IFriend
    import com.sulake.habbo.friendlist.IHabboFriendList
    import com.sulake.habbo.help.IHabboHelp
    import com.sulake.habbo.localization.IHabboLocalizationManager
    import com.sulake.habbo.messenger.events.ActiveConversationEvent
    import com.sulake.habbo.messenger.events.MiniMailMessageEvent
    import com.sulake.habbo.session.ISessionDataManager
    import com.sulake.habbo.sound.class_2240
    import com.sulake.habbo.tracking.IHabboTracking
    import com.sulake.habbo.window.IHabboWindowManager
    import com.sulake.iid.IIDHabboCommunicationManager
    import com.sulake.iid.IIDHabboFriendList
    import com.sulake.iid.IIDHabboHelp
    import com.sulake.iid.IIDHabboLocalizationManager
    import com.sulake.iid.IIDHabboSoundManager
    import com.sulake.iid.IIDHabboTracking
    import com.sulake.iid.IIDHabboWindowManager
    import com.sulake.iid.IIDSessionDataManager

    public class HabboMessenger extends Component implements IHabboMessenger {

        private var _windowManager: IHabboWindowManager;

        private var _communication: IHabboCommunicationManager;

        private var _localization: IHabboLocalizationManager;

        private var _friendList: IHabboFriendList;

        private var _soundManager: class_2240;

        private var _tracking: IHabboTracking;

        private var _miniMailUnreadCount: int = 0;

        private var _sessionDataManager: ISessionDataManager;

        private var _help: IHabboHelp;

        private var _mainView: MainView;

        private var _messageEvents: Vector.<IMessageEvent>;

        private var _roomInvitesIgnored: Boolean = false;

        private var _followingToGroupRoom: Boolean = false;

        public function HabboMessenger(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null) {
            super(param1, param2, param3);
        }

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (param1: IHabboWindowManager): void {
                _windowManager = param1;
            }), new ComponentDependency(new IIDHabboSoundManager(), function (param1: class_2240): void {
                _soundManager = param1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (param1: IHabboCommunicationManager): void {
                _communication = param1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (param1: IHabboLocalizationManager): void {
                _localization = param1;
            }), new ComponentDependency(new IIDHabboFriendList(), function (param1: IHabboFriendList): void {
                _friendList = param1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (param1: ISessionDataManager): void {
                _sessionDataManager = param1;
            }), new ComponentDependency(new IIDHabboTracking(), function (param1: IHabboTracking): void {
                _tracking = param1;
            }), new ComponentDependency(new IIDHabboHelp(), function (param1: IHabboHelp): void {
                _help = param1;
            })]);
        }

        override protected function initComponent(): void {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new MessengerInitEvent(onMessengerInit));
            addMessageEvent(new class_219(onAccountPreferences));
            addMessageEvent(new class_835(onHabboGroupDetails));
            if (getBoolean("client.minimail.embed.enabled")) {
                addMessageEvent(new class_756(onMiniMailMessage));
                addMessageEvent(new class_307(onMiniMailUnreadCount));
            }
        }

        private function addMessageEvent(param1: IMessageEvent): void {
            _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
        }

        override public function dispose(): void {
            if (disposed) {
                return;
            }
            if (_messageEvents != null && _communication != null) {
                for each(var _loc1_: IMessageEvent in _messageEvents) {
                    _communication.removeHabboConnectionMessageEvent(_loc1_);
                }
            }
            super.dispose();
        }

        private function onMiniMailMessage(): void {
            _miniMailUnreadCount++;
            playMessageReceivedSound();
            events.dispatchEvent(new MiniMailMessageEvent("MMME_new", _miniMailUnreadCount));
        }

        private function onMiniMailUnreadCount(param1: IMessageEvent): void {
            _miniMailUnreadCount = (param1.parser as class_1288).unreadMessageCount;
            events.dispatchEvent(new MiniMailMessageEvent("MMME_unread", _miniMailUnreadCount));
        }

        private function onAccountPreferences(param1: class_219): void {
            _roomInvitesIgnored = param1.getParser().roomInvitesIgnored;
        }

        private function onHabboGroupDetails(param1: class_835): void {
            if (_followingToGroupRoom) {
                _followingToGroupRoom = false;
                send(new class_974(param1.data.roomId));
            }
        }

        public function getRoomInvitesIgnored(): Boolean {
            return _roomInvitesIgnored;
        }

        public function setRoomInvitesIgnored(param1: Boolean): void {
            _roomInvitesIgnored = param1;
        }

        private function onMessengerInit(): void {
            _mainView = new MainView(this);
            addMessageEvent(new NewConsoleMessageEvent(onNewConsoleMessage));
            addMessageEvent(new ConsoleMessageHistoryEvent(onConsoleHistory));
            addMessageEvent(new InstantMessageErrorEvent(onInstantMessageError));
            addMessageEvent(new RoomInviteEvent(onRoomInvite));
        }

        public function startConversation(param1: int): void {
            if (_mainView != null) {
                _mainView.startConversation(param1);
                _mainView.show();
            }
        }

        public function getUnseenMiniMailMessageCount(): int {
            return _miniMailUnreadCount;
        }

        public function setFollowingAllowed(param1: int, param2: Boolean): void {
            if (_mainView != null) {
                _mainView.setFollowingAllowed(param1, param2);
            }
        }

        public function setOnlineStatus(param1: int, param2: Boolean): void {
            if (_mainView != null) {
                _mainView.setOnlineStatus(param1, param2);
            }
        }

        public function send(param1: IMessageComposer): void {
            _communication.connection.send(param1);
        }

        public function playSendSound(): void {
            if (_soundManager != null) {
                _soundManager.playSound("HBST_message_sent");
            }
        }

        public function isOpen(): Boolean {
            return _mainView != null && _mainView.isOpen;
        }

        public function toggleMessenger(): void {
            if (_mainView != null) {
                _mainView.toggle();
            }
        }

        public function getText(param1: String): String {
            return _localization.getLocalization(param1, param1);
        }

        private function onNewConsoleMessage(param1: NewConsoleMessageEvent): void {
            var _loc2_: class_1500 = param1.getParser();
            class_14.log("Received console msg: " + _loc2_.messageText + ", " + _loc2_.chatId);
            if (_mainView != null) {
                _mainView.addConsoleMessage(_loc2_.chatId, _loc2_.messageText, _loc2_.secondsSinceSent, _loc2_.messageId, _loc2_.confirmationId, _loc2_.senderId, _loc2_.senderName, _loc2_.senderFigure);
                if (!_mainView.isOpen) {
                    playMessageReceivedSound();
                }
            }
        }

        private function onConsoleHistory(param1: ConsoleMessageHistoryEvent): void {
            var _loc2_: class_1378 = param1.getParser();
            if (_mainView != null) {
                _mainView.loadMessageHistory(_loc2_.chatId, _loc2_.historyFragment);
            }
        }

        private function onRoomInvite(param1: RoomInviteEvent): void {
            var _loc2_: class_1187 = param1.getParser();
            if (_mainView != null) {
                _mainView.addRoomInvite(_loc2_.senderId, _loc2_.messageText);
                if (!_mainView.isOpen) {
                    playMessageReceivedSound();
                }
            }
        }

        private function playMessageReceivedSound(): void {
            if (_soundManager != null) {
                _soundManager.playSound("HBST_message_received");
            }
        }

        private function onInstantMessageError(param1: IMessageEvent): void {
            var _loc2_: class_1375 = (param1 as InstantMessageErrorEvent).getParser();
            if (_mainView != null) {
                _mainView.onInstantMessageError(_loc2_.userId, _loc2_.errorCode, _loc2_.message);
            }
        }

        public function conversationCountUpdated(param1: int, param2: Boolean): void {
            events.dispatchEvent(new ActiveConversationEvent("ACCE_changed", param1, param2));
        }

        public function getXmlWindow(param1: String): IWindow {
            var _loc3_: IAsset = this.findAssetByName(param1 + "_xml");
            var _loc2_: XmlAsset = XmlAsset(_loc3_);
            return _windowManager.buildFromXML(XML(_loc2_.content));
        }

        public function trackGoogle(param1: String, param2: String, param3: int = -1): void {
            if (_tracking) {
                _tracking.trackGoogle(param1, param2, param3);
            }
        }

        internal function getFriend(param1: int, param2: ChatEntry = null): IFriend {
            var _loc3_: IFriend = _friendList.getFriend(param1);
            if (_loc3_ == null && param2 != null) {
                return new DummyFriend(param2.senderId, param2.senderName, param2.senderFigure);
            }
            return _loc3_;
        }

        public function get sessionDataManager(): ISessionDataManager {
            return _sessionDataManager;
        }

        public function get localization(): IHabboLocalizationManager {
            return _localization;
        }

        internal function reportUser(param1: int): void {
            _help.reportUserFromIM(param1);
        }

        public function set followingToGroupRoom(param1: Boolean): void {
            _followingToGroupRoom = param1;
        }

        public function closeConversation(param1: int): void {
            _mainView.hideConversation(param1);
        }
    }
}
