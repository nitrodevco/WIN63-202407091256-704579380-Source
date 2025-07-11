package com.sulake.habbo.ui.widget {
    import com.sulake.core.assets.IAsset
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.runtime.events.EventDispatcherWrapper
    import com.sulake.core.window.IWindow
    import com.sulake.habbo.localization.IHabboLocalizationManager
    import com.sulake.habbo.ui.IRoomWidgetHandler
    import com.sulake.habbo.window.IHabboWindowManager

    import flash.events.IEventDispatcher

    public class RoomWidgetBase implements IRoomWidget {

        private var _disposed: Boolean = false;

        private var name_1: EventDispatcherWrapper;

        private var var_85: IRoomWidgetMessageListener;

        private var _windowManager: IHabboWindowManager;

        protected var _assets: IAssetLibrary;

        protected var var_44: IHabboLocalizationManager;

        protected var var_1653: IRoomWidgetHandler;

        public function RoomWidgetBase(param1: IRoomWidgetHandler, param2: IHabboWindowManager, param3: IAssetLibrary = null, param4: IHabboLocalizationManager = null) {
            super();
            var_1653 = param1;
            _windowManager = param2;
            _assets = param3;
            var_44 = param4;
        }

        public function get state(): int {
            return 0;
        }

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function initialize(param1: int = 0): void {
        }

        public function dispose(): void {
            if (disposed) {
                return;
            }
            var_85 = null;
            _windowManager = null;
            if (name_1 != null && !name_1.disposed) {
                unregisterUpdateEvents(name_1);
            }
            if (var_1653) {
                var_1653.dispose();
                var_1653 = null;
            }
            name_1 = null;
            _assets = null;
            var_44 = null;
            _disposed = true;
        }

        public function set messageListener(param1: IRoomWidgetMessageListener): void {
            var_85 = param1;
        }

        public function get messageListener(): IRoomWidgetMessageListener {
            return var_85;
        }

        public function get windowManager(): IHabboWindowManager {
            return _windowManager;
        }

        public function findAssetByName(param1: String): IAsset {
            return _assets.getAssetByName(param1);
        }

        public function get assets(): IAssetLibrary {
            return _assets;
        }

        public function get localizations(): IHabboLocalizationManager {
            return var_44;
        }

        public function registerUpdateEvents(param1: IEventDispatcher): void {
            if (param1 is EventDispatcherWrapper) {
                name_1 = param1 as EventDispatcherWrapper;
            }
        }

        public function unregisterUpdateEvents(param1: IEventDispatcher): void {
        }

        public function get mainWindow(): IWindow {
            return null;
        }
    }
}
