package com.sulake.habbo.friendlist {
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.core.assets.IAsset
    import com.sulake.core.assets.XmlAsset
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.communication.messages.IMessageComposer
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.runtime.Component
    import com.sulake.core.runtime.ComponentDependency
    import com.sulake.core.runtime.IContext
    import com.sulake.core.runtime.events.ILinkEventTracker
    import com.sulake.core.window.IWindow
    import com.sulake.core.window.IWindowContainer
    import com.sulake.core.window.components.IBitmapWrapperWindow
    import com.sulake.core.window.components.IRegionWindow
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow
    import com.sulake.habbo.avatar.IAvatarImageListener
    import com.sulake.habbo.avatar.IAvatarRenderManager
    import com.sulake.habbo.avatar.class_3374
    import com.sulake.habbo.communication.IHabboCommunicationManager
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendFailureData
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendResultEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FriendListUpdateMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.MessengerInitMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetRelationshipStatusMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetFriendRequestsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestFriendMessageEvent
    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.AcceptFriendResultMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendRequestsMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendsListFragmentMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitParser
    import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestMessageParser
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser
    import com.sulake.habbo.communication.messages.parser.handshake.class_1267
    import com.sulake.habbo.friendlist.domain.*
    import com.sulake.habbo.localization.IHabboLocalizationManager
    import com.sulake.habbo.messenger.IHabboMessenger
    import com.sulake.habbo.notifications.IHabboNotifications
    import com.sulake.habbo.session.ISessionDataManager
    import com.sulake.habbo.tracking.IHabboTracking
    import com.sulake.habbo.utils.HabboWebTools
    import com.sulake.habbo.window.IHabboWindowManager
    import com.sulake.iid.IIDAvatarRenderManager
    import com.sulake.iid.IIDHabboCommunicationManager
    import com.sulake.iid.IIDHabboLocalizationManager
    import com.sulake.iid.IIDHabboMessenger
    import com.sulake.iid.IIDHabboNotifications
    import com.sulake.iid.IIDHabboTracking
    import com.sulake.iid.IIDHabboWindowManager
    import com.sulake.iid.IIDSessionDataManager

    import flash.display.BitmapData
    import flash.events.Event
    import flash.geom.Point
    import flash.geom.Rectangle
    import flash.utils.Dictionary
    import flash.utils.Timer
    import flash.utils.getTimer

    public class HabboFriendList extends Component implements IHabboFriendList, IAvatarImageListener, ILinkEventTracker {

        public static const AVATAR_FACE_NAME: String = "face";

        private var _windowManager: IHabboWindowManager;

        private var _communication: IHabboCommunicationManager;

        private var _messenger: IHabboMessenger;

        private var _localization: IHabboLocalizationManager;

        private var _avatarManager: IAvatarRenderManager;

        private var _sessionData: ISessionDataManager;

        private var _tracking: IHabboTracking;

        private var _laf: FriendListColorScheme;

        private var _tabs: FriendListTabs;

        private var _view: FriendListView;

        private var _openedToWebPopup: OpenedToWebPopup;

        private var _avatarId: int;

        internal var _categories: FriendCategories;

        private var _friendRequests: FriendRequests;

        private var _avatarSearchResults: AvatarSearchResults;

        private var _notifications: IHabboNotifications;

        private var _updateTimer: Timer;

        private var var_4364: int;

        private var _hasfriendsListInitialized: Boolean = false;

        private var _lastRoomInvitationTime: int = -60000;

        public function HabboFriendList(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null) {
            super(param1, param2, param3);
            _categories = new FriendCategories(new FriendCategoriesDeps(this));
            _avatarSearchResults = new AvatarSearchResults(new AvatarSearchDeps(this));
            _laf = new FriendListColorScheme();
        }

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (param1: IHabboCommunicationManager): void {
                _communication = param1;
            }), new ComponentDependency(new IIDHabboTracking(), function (param1: IHabboTracking): void {
                _tracking = param1;
            }), new ComponentDependency(new IIDHabboMessenger(), function (param1: IHabboMessenger): void {
                _messenger = param1;
            }, false), new ComponentDependency(new IIDAvatarRenderManager(), function (param1: IAvatarRenderManager): void {
                _avatarManager = param1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (param1: IHabboLocalizationManager): void {
                _localization = param1;
            }), new ComponentDependency(new IIDHabboNotifications(), function (param1: IHabboNotifications): void {
                _notifications = param1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (param1: IHabboWindowManager): void {
                _windowManager = param1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (param1: ISessionDataManager): void {
                _sessionData = param1;
            })]);
        }

        override protected function initComponent(): void {
            _communication.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
            _communication.addHabboConnectionMessageEvent(new MessengerInitEvent(onMessengerInit));
            _communication.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
            context.addLinkEventTracker(this);
            send(new MessengerInitMessageComposer());
        }

        override public function dispose(): void {
            if (disposed) {
                return;
            }
            context.removeLinkEventTracker(this);
            if (_updateTimer) {
                _updateTimer.stop();
                _updateTimer.removeEventListener("timer", sendFriendListUpdate);
                _updateTimer = null;
            }
            super.dispose();
        }

        public function send(param1: IMessageComposer): void {
            _communication.connection.send(param1);
        }

        public function trackGoogle(param1: String, param2: String, param3: int = -1): void {
            if (_tracking != null) {
                _tracking.trackGoogle(param1, param2, param3);
            }
        }

        public function openHabboWebPage(param1: String, param2: Dictionary, param3: int, param4: int): void {
            var _loc6_: String = getProperty(param1, param2);
            var _loc5_: String = "habboMain";
            try {
                HabboWebTools.navigateToURL(_loc6_, _loc5_);
            } catch (e: Error) {
                class_14.log("GOT ERROR: " + e);
            }
            if (_openedToWebPopup == null) {
                _openedToWebPopup = new OpenedToWebPopup(this);
            }
            _openedToWebPopup.show(param3, param4);
        }

        public function getText(param1: String): String {
            return _localization.getLocalization(param1);
        }

        public function registerParameter(param1: String, param2: String, param3: String): void {
            _localization.registerParameter(param1, param2, param3);
        }

        public function showLimitReachedAlert(): void {
            registerParameter("friendlist.listfull.text", "mylimit", "" + friendRequests.limit);
            registerParameter("friendlist.listfull.text", "clublimit", "" + friendRequests.clubLimit);
            simpleAlert("${friendlist.listfull.title}", "${friendlist.listfull.text}");
        }

        public function showFriendRequestSentAlert(param1: String): void {
            registerParameter("friendlist.friendrequestsent.text", "user_name", param1);
            simpleAlert("${friendlist.friendrequestsent.title}", "${friendlist.friendrequestsent.text}");
        }

        public function getFriend(param1: int): IFriend {
            if (_view == null) {
                class_14.log("Cannot process getFriend. Friendlist not initialized.");
                return null;
            }
            return _categories.findFriend(param1);
        }

        public function canBeAskedForAFriend(param1: int): Boolean {
            if (_view == null) {
                class_14.log("Cannot process canBeAskedForAFriend. Friendlist not initialized.");
                return false;
            }
            return this.getFriend(param1) == null && !searchResults.isFriendRequestSent(param1) && categories.getFriendCount(false) < friendRequests.limit;
        }

        public function askForAFriend(param1: int, param2: String): Boolean {
            if (_view == null) {
                class_14.log("Cannot ask for friend. Friendlist not initialized.");
                return false;
            }
            if (searchResults.isFriendRequestSent(param1)) {
                return true;
            }
            if (!canBeAskedForAFriend(param1)) {
                return false;
            }
            send(new RequestFriendMessageEvent(param2));
            searchResults.setFriendRequestSent(param1);
            send(new FriendRequestQuestCompleteMessageEvent());
            return true;
        }

        public function openFriendList(): void {
            openFriendListWithTab(1);
        }

        public function openFriendRequests(): void {
            openFriendListWithTab(2);
        }

        public function openFriendSearch(): void {
            openFriendListWithTab(3);
            SearchView(_tabs.findTab(3).tabView).focus();
        }

        public function close(): void {
            if (_view) {
                _view.close();
            }
        }

        public function alignBottomLeftTo(param1: Point): void {
            if (_view) {
                _view.alignBottomLeftTo(param1);
            }
        }

        public function isOpen(): Boolean {
            if (_view) {
                return _view.isOpen();
            }
            return false;
        }

        public function currentTabId(): int {
            if (_view == null || !_view.isOpen()) {
                return 0;
            }
            return var_4364;
        }

        private function openFriendListWithTab(param1: int): void {
            if (_view == null) {
                class_14.log("Cannot open friendlist. Friendlist not initialized.");
                return;
            }
            _view.openFriendList();
            var _loc2_: FriendListTab = tabs.findTab(param1);
            if (_loc2_ != tabs.findSelectedTab()) {
                tabs.toggleSelected(_loc2_);
                view.refresh("openFriendList");
            }
            _view.mainWindow.activate();
            var_4364 = param1;
        }

        public function getFriendCount(param1: Boolean, param2: Boolean): int {
            if (_view == null) {
                class_14.log("Cannot get friend count. Friendlist not initialized.");
                return 0;
            }
            return this._categories.getFriendCount(param1, param2);
        }

        public function getButton(param1: String, param2: String, param3: Function, param4: int = 0, param5: int = 0, param6: int = 0): IBitmapWrapperWindow {
            var _loc8_: BitmapData = getButtonImage(param2);
            var _loc7_: IBitmapWrapperWindow;
            (_loc7_ = _windowManager.createWindow(param1, "", 21, 0, 1 | 16, new Rectangle(param4, param5, _loc8_.width, _loc8_.height), param3, param6) as IBitmapWrapperWindow).bitmap = _loc8_;
            return _loc7_;
        }

        public function getXmlWindow(param1: String): IWindow {
            var _loc3_: IAsset = this.findAssetByName(param1 + "_xml");
            var _loc2_: XmlAsset = XmlAsset(_loc3_);
            return _windowManager.buildFromXML(XML(_loc2_.content));
        }

        public function isMessagesPersisted(): Boolean {
            return getBoolean("friend_list.persistent_message_status.enabled");
        }

        public function getSmallGroupBadgeBitmap(param1: String): BitmapData {
            if (_sessionData) {
                return _sessionData.getGroupBadgeSmallImage(param1);
            }
            return null;
        }

        public function getAvatarFaceBitmap(param1: String): BitmapData {
            var _loc3_: Boolean = getBoolean("zoom.enabled");
            var _loc4_: class_3374;
            if (!(_loc4_ = _avatarManager.createAvatarImage(param1, _loc3_ ? "h" : "sh", null, this))) {
                return null;
            }
            var _loc2_: BitmapData = _loc4_.getCroppedImage("head", _loc3_ ? 0.5 : 1);
            _loc4_.dispose();
            return _loc2_;
        }

        public function isEmbeddedMinimailEnabled(): Boolean {
            var _loc1_: String = getProperty("client.minimail.embed.enabled");
            return _loc1_ == "true";
        }

        private function onUserObject(param1: IMessageEvent): void {
            var _loc2_: class_1267 = (param1 as UserObjectEvent).getParser();
            _avatarId = _loc2_.id;
        }

        private function onFriendsListFragment(event: IMessageEvent): void {
            var parser: FriendsListFragmentMessageParser = (event as FriendListFragmentMessageEvent).getParser();

            for each (var friendData: FriendData in parser.friendFragment) {
                _categories.addFriend(new Friend(friendData));
            }

            _categories.sort();

            if (parser.fragmentNo == parser.totalFragments - 1) {
                _hasfriendsListInitialized = true;
            }
        }

        private function onMessengerInit(event: IMessageEvent): void {
            _view = new FriendListView(this);

            var parser: MessengerInitParser = (event as MessengerInitEvent).getParser();
            _friendRequests = new FriendRequests(new FriendRequestsDeps(this), parser.userFriendLimit, parser.extendedFriendLimit);

            for each (var categoryData: FriendCategory in parser.categories) {
                _categories.addCategory(new FriendCategory(categoryData.id, categoryData.name));
            }

            _categories.addCategory(new FriendCategory(0, getText("friendlist.friends")));
            _categories.addCategory(new FriendCategory(-1, getText("friendlist.friends.offlinecaption")));

            _tabs = new FriendListTabs(new FriendListTabsDeps(this));

            if (!_updateTimer) {
                _updateTimer = new Timer(120000);
                _updateTimer.addEventListener("timer", sendFriendListUpdate);
                _updateTimer.start();
            }

            getFriendRequests();
            registerListeners();

            if (_categories.getFriendCount(true, false) == 0) {
                var offlineCategory: FriendCategory = _categories.findCategory(-1);
                if (offlineCategory) {
                    offlineCategory.setOpen(true);
                }
            }

            class_14.log("FRIENDLIST INITIALIZED SUCCESSFULLY");
        }

        public function trackFriendListEvent(param1: String): void {
            events.dispatchEvent(new Event(param1));
        }

        private function getSortedFriends(param1: Array): Array {
            var _loc3_: Array = [];
            var _loc6_: Dictionary = new Dictionary();
            for each(var _loc5_ in param1) {
                _loc3_.push(_loc5_.name.toLowerCase());
                _loc6_[_loc5_.name.toLowerCase()] = _loc5_;
            }
            _loc3_.sort();
            var _loc2_: Array = [];
            for each(var _loc4_ in _loc3_) {
                _loc2_.push(_loc6_[_loc4_]);
            }
            return _loc2_;
        }

        private function registerListeners(): void {
            _communication.addHabboConnectionMessageEvent(new AcceptFriendResultEvent(onAcceptFriendResult));
            _communication.addHabboConnectionMessageEvent(new RoomInviteErrorEvent(onRoomInviteError));
            _communication.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
            _communication.addHabboConnectionMessageEvent(new FollowFriendFailedEvent(onFollowFriendFailed));
            _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
            _communication.addHabboConnectionMessageEvent(new HabboSearchResultEvent(onHabboSearchResult));
            _communication.addHabboConnectionMessageEvent(new FriendRequestsEvent(onFriendRequests));
            _communication.addHabboConnectionMessageEvent(new NewFriendRequestEvent(onNewFriendRequest));
            _communication.addHabboConnectionMessageEvent(new MessengerErrorEvent(onMessengerError));
        }

        private function getFriendRequests(): void {
            class_14.log("Sending friend requests request");
            send(new GetFriendRequestsMessageComposer());
        }

        protected function sendFriendListUpdate(param1: Event): void {
            class_14.log("Sending update request");
            send(new FriendListUpdateMessageComposer());
        }

        private function onFriendRequests(param1: IMessageEvent): void {
            var parser: FriendRequestsMessageParser = (param1 as FriendRequestsEvent).getParser();
            _friendRequests.clearAndUpdateView(false);

            for each(var request: FriendRequestData in parser.reqs) {
                _friendRequests.addRequest(new FriendRequest(request));
            }

            if (parser.reqs.length > 0) {
                _tabs.findTab(2).setNewMessageArrived(true);
            }

            _view.refresh("friendRequests");
        }

        private function onNewFriendRequest(event: IMessageEvent): void {
            class_14.log("Received new friend request");

            var parser: NewFriendRequestMessageParser = (event as NewFriendRequestEvent).getParser();
            var newFriendRequest: FriendRequest = new FriendRequest(parser.req);

            _friendRequests.addRequestAndUpdateView(newFriendRequest);

            var friendListTab: FriendListTab = _tabs.findTab(2);
            friendListTab.setNewMessageArrived(true);

            _view.refresh("newFriendRequest");
        }

        private function onAcceptFriendResult(event: IMessageEvent): void {
            var parser: AcceptFriendResultMessageParser = (event as AcceptFriendResultEvent).getParser();

            for each (var failure: AcceptFriendFailureData in parser.failures) {
                _friendRequests.acceptFailed(failure.senderId);
                showAlertView(failure.errorCode);
            }
        }

        private function onHabboSearchResult(event: IMessageEvent): void {
            var parser: HabboSearchResultMessageParser = (event as HabboSearchResultEvent).getParser();
            _avatarSearchResults.searchReceived(parser.friends, parser.others);
            _view.refresh("search");
        }

        private function onMessengerError(event: IMessageEvent): void {
            var parser: MessengerErrorMessageParser = (event as MessengerErrorEvent).getParser();
            showAlertView(parser.errorCode, parser.clientMessageId);
        }

        private function showAlertView(errorCode: int, param2: int = 0): void {
            var _loc3_: String;
            switch (errorCode - 1) {
                case 0:
                    _loc3_ = "${friendlist.error.friendlistownlimit}";
                    break;
                case 1:
                    _loc3_ = "${friendlist.error.friendlistlimitofrequester}";
                    break;
                case 2:
                    _loc3_ = "${friendlist.error.friend_requests_disabled}";
                    break;
                case 3:
                    _loc3_ = "${friendlist.error.requestnotfound}";
                    break;
                default:
                    _loc3_ = "Received messenger error: msg: " + param2 + ", errorCode: " + errorCode;
            }
            simpleAlert("${friendlist.alert.title}", _loc3_);
        }

        private function onRoomInviteError(event: IMessageEvent): void {
            var parser: RoomInviteErrorMessageParser = (event as RoomInviteErrorEvent).getParser();
            var errorMessage: String = "Received room invite error: errorCode: " + parser.errorCode + ", recipients: " + Util.arrayToString(parser.failedRecipients);
            simpleAlert("${friendlist.alert.title}", errorMessage);
        }

        private function onFriendListUpdate(param1: IMessageEvent): void {
            _categories.onFriendListUpdate(param1);
            _view.refresh("friendListUpdate");
        }

        private function onFollowFriendFailed(event: IMessageEvent): void {
            var parser: FollowFriendFailedMessageParser = (event as FollowFriendFailedEvent).getParser();
            var errorMessage: String = getFollowFriendErrorText(parser.errorCode);
            class_14.log("Received follow friend failed: " + parser.errorCode + ", " + errorMessage);
            simpleAlert("${friendlist.alert.title}", errorMessage);
        }

        public function simpleAlert(param1: String, param2: String): void {
            windowManager.simpleAlert(param1, null, param2);
        }

        private function getFollowFriendErrorText(errorCode: int): String {
            switch (errorCode) {
                case 0:
                    return "${friendlist.followerror.notfriend}";
                case 1:
                    return "${friendlist.followerror.offline}";
                case 2:
                    return "${friendlist.followerror.hotelview}";
                case 3:
                    return "${friendlist.followerror.prevented}";
                default:
                    return "Unknown follow friend error " + errorCode;
            }
        }

        public function refreshText(container: IWindowContainer, name: String, isVisible: Boolean, text: String): void {
            var textWindow: IWindow = container.getChildByName(name);
            if (!isVisible) {
                textWindow.visible = false;
            } else {
                textWindow.visible = true;
                textWindow.caption = text;
            }
        }

        public function refreshButton(container: IWindowContainer, name: String, isVisible: Boolean, callback: Function, id: int): void {
            var button: IWindow = container.findChildByName(name) as IWindow;
            if (!isVisible) {
                button.visible = false;
            } else {
                prepareButton(button, name, callback, id);
                button.visible = true;
            }
        }

        public function refreshRelationshipRegion(container: IWindowContainer, name: String, status: int, callback: Function, id: int): void {
            var region: IRegionWindow = IRegionWindow(container.findChildByName(name));
            var bitmap: IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(region.findChildByTag("bitmap"));

            var statusAssetUri: String = "relationship_status_none";
            switch (status) {
                case 1:
                    statusAssetUri = "relationship_status_heart";
                    break;
                case 2:
                    statusAssetUri = "relationship_status_smile";
                    break;
                case 3:
                    statusAssetUri = "relationship_status_bobba";
                    break;
            }

            bitmap.assetUri = statusAssetUri;
            bitmap.visible = true;
            region.id = id;
            region.procedure = callback;
            region.visible = id > 0 && getBoolean("relationship.status.enabled");
        }

        public function refreshIcon(container: IWindowContainer, name: String, isVisible: Boolean, callback: Function, id: int): void {
            var icon: IWindow = container.findChildByName(name);

            if (!isVisible) {
                icon.visible = false;
            } else {
                icon.id = id;
                icon.procedure = callback;
                icon.visible = true;
            }
        }

        private function prepareButton(button: IWindow, imageName: String, callback: Function, id: int): void {
            var bitmapWrapper: IBitmapWrapperWindow;

            button.id = id;

            if (button is IBitmapWrapperWindow) {
                bitmapWrapper = button as IBitmapWrapperWindow;
            } else {
                bitmapWrapper = IWindowContainer(button).findChildByTag("bitmap") as IBitmapWrapperWindow;
            }

            if (bitmapWrapper.bitmap != null) {
                return;
            }

            bitmapWrapper.bitmap = getButtonImage(imageName);
            bitmapWrapper.width = bitmapWrapper.bitmap.width;
            bitmapWrapper.height = bitmapWrapper.bitmap.height;
            button.procedure = callback;
        }

        public function getButtonImage(name: String): BitmapData {
            var asset: IAsset = this.findAssetByName(name + "_png");
            var bitmapDataAsset: BitmapDataAsset = asset as BitmapDataAsset;
            class_14.log("GETTING ASSET: " + name);

            var sourceBitmap: BitmapData = bitmapDataAsset.content as BitmapData;
            class_14.log("GOT ASSET: " + asset + ", " + sourceBitmap);

            var resultBitmap: BitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 0);
            resultBitmap.draw(sourceBitmap);
            return resultBitmap;
        }

        public function get lastRoomInvitationTime(): * {
            return _lastRoomInvitationTime;
        }

        public function resetLastRoomInvitationTime(): void {
            _lastRoomInvitationTime = getTimer();
        }

        public function get hasfriendsListInitialized(): Boolean {
            return _hasfriendsListInitialized;
        }

        public function get windowManager(): IHabboWindowManager {
            return _windowManager;
        }

        public function get categories(): FriendCategories {
            return _categories;
        }

        public function get friendRequests(): FriendRequests {
            return _friendRequests;
        }

        public function get searchResults(): AvatarSearchResults {
            return _avatarSearchResults;
        }

        public function get view(): FriendListView {
            return _view;
        }

        public function get tabs(): FriendListTabs {
            return _tabs;
        }

        public function get laf(): FriendListColorScheme {
            return _laf;
        }

        public function get messenger(): IHabboMessenger {
            return _messenger;
        }

        public function get avatarId(): int {
            return _avatarId;
        }

        public function get notifications(): IHabboNotifications {
            return _notifications;
        }

        public function get tracking(): IHabboTracking {
            return _tracking;
        }

        public function get mainWindow(): IWindowContainer {
            if (_view == null) {
                return null;
            }
            return _view.mainWindow;
        }

        public function getFriendNames(): Array {
            if (_categories == null) {
                return [];
            }
            return _categories.getFriendNames();
        }

        public function acceptFriendRequest(requestId: int): void {
            if (!_tabs) {
                return;
            }

            var friendRequestsTab: FriendListTab = _tabs.findTab(2);
            if (!friendRequestsTab) {
                return;
            }

            var friendRequestsView: IFriendRequestsView = friendRequestsTab.tabView as IFriendRequestsView;
            if (!friendRequestsView) {
                return;
            }

            friendRequestsView.acceptRequest(requestId);
        }

        public function acceptAllFriendRequests(): void {
            var friendRequestsTab: FriendListTab = _tabs.findTab(2);
            if (!friendRequestsTab) {
                return;
            }

            var friendRequestsView: IFriendRequestsView = friendRequestsTab.tabView as IFriendRequestsView;
            if (!friendRequestsView) {
                return;
            }

            friendRequestsView.acceptAllRequests();
        }

        public function declineFriendRequest(requestId: int): void {
            var friendRequestsTab: FriendListTab = _tabs.findTab(2);
            if (!friendRequestsTab) {
                return;
            }

            var friendRequestsView: IFriendRequestsView = friendRequestsTab.tabView as IFriendRequestsView;
            if (!friendRequestsView) {
                return;
            }

            friendRequestsView.declineRequest(requestId);
        }

        public function declineAllFriendRequests(): void {
            var friendRequestsTab: FriendListTab = _tabs.findTab(2);
            if (!friendRequestsTab) {
                return;
            }

            var friendRequestsView: IFriendRequestsView = friendRequestsTab.tabView as IFriendRequestsView;
            if (!friendRequestsView) {
                return;
            }

            friendRequestsView.declineAllRequests();
        }

        public function setRelationshipStatus(param1: int, param2: int): void {
            send(new SetRelationshipStatusMessageComposer(param1, param2));
        }

        public function getRelationshipStatus(friendId: int): int {
            var friend: Friend = _categories.findFriend(friendId);
            if (friend) {
                return friend.relationshipStatus;
            }
            return 0;
        }

        private function onUserRights(event: IMessageEvent): void {
            if (!_sessionData || !_friendRequests) {
                return;
            }

            var newLimit: int = 0;
            if (_sessionData.hasVip || _sessionData.hasClub) {
                newLimit = _friendRequests.clubLimit;
            }

            if (newLimit > _friendRequests.limit) {
                _friendRequests.limit = newLimit;
            }
        }

        public function avatarImageReady(figure: String): void {
            if (disposed || _categories == null) {
                return;
            }

            var allFriends: Dictionary = _categories.getAllFriends();
            if (allFriends == null) {
                return;
            }

            for each (var friend: Friend in allFriends) {
                if (friend != null && !friend.disposed && friend.figure == figure) {
                    friend.face = friend.isGroupFriend() ? getSmallGroupBadgeBitmap(friend.figure) : getAvatarFaceBitmap(friend.figure);

                    if (friend.face != null) {
                        var friendView: IWindowContainer = friend.view;
                        if (friendView != null) {
                            var faceWindow: IBitmapWrapperWindow = friendView.getChildByName("face") as IBitmapWrapperWindow;
                            if (faceWindow != null && !faceWindow.disposed) {
                                var bitmap: BitmapData = faceWindow.bitmap;
                                if (bitmap != null) {
                                    bitmap.fillRect(bitmap.rect, 0);
                                    bitmap.copyPixels(friend.face, friend.face.rect, new Point(0, 0), null, null, true);
                                }
                                faceWindow.invalidate();
                            }
                        }
                    }
                }
            }
        }

        public function get linkPattern(): String {
            return "friendlist/";
        }

        public function linkReceived(link: String): void {
            var parts: Array = link.split("/");
            if (parts.length < 2) {
                return;
            }

            switch (parts[1]) {
                case "open":
                    openFriendList();
                    break;

                case "openchat":
                    if (parts.length < 3 || _messenger == null) {
                        return;
                    }

                    var chatParts: Array = parts[2].split(":");
                    if (chatParts.length < 2) {
                        return;
                    }

                    var chatId: int = (int(chatParts[0]) == _avatarId) ? int(chatParts[1]) : int(chatParts[0]);
                    if (chatId > 0) {
                        openFriendList();
                        _messenger.startConversation(chatId);
                    }
                    break;

                default:
                    class_14.log("FriendList unknown link-type received: " + parts[1]);
            }
        }
    }
}
