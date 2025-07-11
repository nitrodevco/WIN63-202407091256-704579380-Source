package com.sulake.habbo.friendlist {
   import assets.class_14

   import com.sulake.core.window.IWindow
   import com.sulake.core.window.IWindowContainer
   import com.sulake.core.window.components.ITextWindow
   import com.sulake.core.window.components.class_3514
   import com.sulake.core.window.events.WindowMouseEvent
   import com.sulake.core.window.events.WindowEvent

   import flash.geom.Point
   import flash.utils.Dictionary

   public class FriendListView {

        private static const DEFAULT_LOCATION: Point = new Point(110, 50);

        private static const MIN_LEFT_MARGIN: int = 110;

        private static const const_844: int = 1;

        private var _friendList: HabboFriendList;

        private var _friendListTabsView: FriendListTabsView;

        private var _mainWindow: class_3514;

        private var _windowContainer: IWindowContainer;

        private var _footer: IWindowContainer;

        private var _textWindow: ITextWindow;

        private var _lastWindowHeight: int = -1;

        private var _lastWindowWidth: int = -1;

        private var _ignoreResizeEvents: Boolean;

        public function FriendListView(param1: HabboFriendList) {
            super();
            _friendList = param1;
            _friendListTabsView = new FriendListTabsView(_friendList);
        }

        public function openFriendList(): void {
            if (_mainWindow == null) {
                prepare();
                _mainWindow.position = DEFAULT_LOCATION;
            } else {
                _mainWindow.visible = true;
                _mainWindow.activate();
            }
        }

        public function showInfo(param1: WindowEvent, param2: String): void {
            var _loc3_: WindowMouseEvent = param1 as WindowMouseEvent;
            if (_loc3_ == null) {
                return;
            }
            if (_loc3_.type == "WME_OUT") {
                _textWindow.text = "";
            } else if (_loc3_.type == "WME_OVER") {
                _textWindow.text = param2;
            }
        }

        public function refresh(param1: String): void {
            if (this._mainWindow == null) {
                return;
            }
            _friendListTabsView.refresh(param1);
            refreshWindowSize();
        }

        public function close(): void {
            if (this._mainWindow != null) {
                this._mainWindow.visible = false;
            }
        }

        public function isOpen(): Boolean {
            return _mainWindow && _mainWindow.visible;
        }

        private function prepare(): void {
            _mainWindow = class_3514(_friendList.getXmlWindow("main_window"));
            _mainWindow.findChildByTag("close").procedure = onWindowClose;
            _windowContainer = IWindowContainer(_mainWindow.content.findChildByName("main_content"));
            _footer = IWindowContainer(_mainWindow.content.findChildByName("footer"));
            _friendListTabsView.prepare(_windowContainer);
            _mainWindow.procedure = onWindow;
            _mainWindow.content.setParamFlag(3072, false);
            _mainWindow.content.setParamFlag(0, true);
            _mainWindow.header.setParamFlag(192, false);
            _mainWindow.header.setParamFlag(0, true);
            _mainWindow.content.setParamFlag(192, false);
            _mainWindow.content.setParamFlag(0, true);
            var _loc1_: Boolean = _friendList.getBoolean("friendship.category.management.enabled");
            if (_loc1_ && _friendList.getInteger("spaweb", 0) != 1) {
                _mainWindow.findChildByName("open_edit_ctgs_but").procedure = onEditCategoriesButtonClick;
            } else {
                _mainWindow.findChildByName("open_edit_ctgs_but").visible = false;
            }
            _textWindow = ITextWindow(_mainWindow.findChildByName("info_text"));
            _textWindow.text = "";
            _friendList.refreshButton(_mainWindow, "open_edit_ctgs", true, null, 0);
            refresh("prepare");
            _mainWindow.height = 350;
            _mainWindow.width = 230;
        }

        private function onWindowClose(param1: WindowEvent, param2: IWindow): void {
            if (param1.type != "WME_CLICK") {
                return;
            }
            class_14.log("Close window");
            _mainWindow.visible = false;
            _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED");
            _friendList.categories.view.refreshed();
        }

        private function onWindow(event: WindowEvent, window: IWindow): void {
            if (event.type == "WE_RELOCATE" || event.type == "WE_RESIZED") {
                _friendList.categories.view.refreshed();
            }
            if (event.type != "WE_RESIZED" || window != _mainWindow) {
                return;
            }
            if (this._ignoreResizeEvents) {
                return;
            }
            var heightDifference: int = _lastWindowHeight == -1 ? 0 : _mainWindow.height - _lastWindowHeight;
            var widthDifference: int = _lastWindowWidth == -1 ? 0 : _mainWindow.width - _lastWindowWidth;
            _friendList.tabs.tabContentHeight = Math.max(100, _friendList.tabs.tabContentHeight + heightDifference);
            _friendList.tabs.windowWidth = Math.max(147, _friendList.tabs.windowWidth + widthDifference);
            refresh("resize: " + heightDifference);
        }

        private function refreshWindowSize(): void {
            this._ignoreResizeEvents = true;
            _footer.visible = false;
            _footer.y = Util.getLowestPoint(_mainWindow.content);
            _footer.width = _friendList.tabs.windowWidth;
            _footer.visible = true;
            _mainWindow.content.height = Util.getLowestPoint(_mainWindow.content);
            _mainWindow.content.width = _friendList.tabs.windowWidth - 10;
            _mainWindow.header.width = _friendList.tabs.windowWidth - 10;
            _mainWindow.height = _mainWindow.content.height + 30;
            _mainWindow.width = _friendList.tabs.windowWidth;
            this._ignoreResizeEvents = false;
            _mainWindow.scaler.setParamFlag(12288, false);
            _mainWindow.scaler.setParamFlag(12288, this._friendList.tabs.findSelectedTab() != null);
            _mainWindow.scaler.setParamFlag(192, false);
            _mainWindow.scaler.setParamFlag(3072, false);
            _mainWindow.scaler.x = _mainWindow.width - _mainWindow.scaler.width;
            _mainWindow.scaler.y = _mainWindow.height - _mainWindow.scaler.height;
            _lastWindowHeight = _mainWindow.height;
            _lastWindowWidth = _mainWindow.width;
            class_14.log("RESIZED: " + _friendList.tabs.windowWidth);
        }

        private function onEditCategoriesButtonClick(event: WindowEvent, param2: IWindow): void {
            _friendList.view.showInfo(event, "${friendlist.tip.preferences}");
            if (event.type != "WME_CLICK") {
                return;
            }
            class_14.log("Edit categories clicked");
            var mouseEvent: WindowMouseEvent = event as WindowMouseEvent;
            _friendList.openHabboWebPage("link.format.friendlist.pref", new Dictionary(), mouseEvent.stageX, mouseEvent.stageY);
        }

        public function get mainWindow(): IWindowContainer {
            return _mainWindow;
        }

        public function alignBottomLeftTo(param1: Point): void {
            var _loc2_: Point = param1.clone();
            _loc2_.y -= _mainWindow.height;
            var _loc3_: int = int(_friendList.windowManager.getWindowContext(1).getDesktopWindow().width);
            _loc2_.x = Math.min(_loc3_ - _mainWindow.width, _loc2_.x);
            _loc2_.x = Math.max(110, _loc2_.x);
            _mainWindow.position = _loc2_;
        }
    }
}
