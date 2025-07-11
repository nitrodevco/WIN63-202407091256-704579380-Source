package com.sulake.core.window.events {
    import com.sulake.core.window.IWindow

    public class WindowEvent {

        public static const const_942: String = "WE_DESTROY";

        public static const const_666: String = "WE_DESTROYED";

        public static const const_1137: String = "WE_OPEN";

        public static const const_1135: String = "WE_OPENED";

        public static const const_1122: String = "WE_CLOSE";

        public static const const_1143: String = "WE_CLOSED";

        public static const WINDOW_EVENT_FOCUS: String = "WE_FOCUS";

        public static const const_1064: String = "WE_FOCUSED";

        public static const WINDOW_EVENT_UNFOCUS: String = "WE_UNFOCUS";

        public static const const_837: String = "WE_UNFOCUSED";

        public static const const_636: String = "WE_ACTIVATE";

        public static const const_1157: String = "WE_ACTIVATED";

        public static const const_729: String = "WE_DEACTIVATE";

        public static const const_559: String = "WE_DEACTIVATED";

        public static const const_643: String = "WE_SELECT";

        public static const const_1170: String = "WE_SELECTED";

        public static const const_853: String = "WE_UNSELECT";

        public static const const_806: String = "WE_UNSELECTED";

        public static const WINDOW_EVENT_LOCK: String = "WE_LOCK";

        public static const const_949: String = "WE_LOCKED";

        public static const WINDOW_EVENT_UNLOCK: String = "WE_UNLOCK";

        public static const const_537: String = "WE_UNLOCKED";

        public static const const_552: String = "WE_ENABLE";

        public static const const_859: String = "WE_ENABLED";

        public static const const_1204: String = "WE_DISABLE";

        public static const const_773: String = "WE_DISABLED";

        public static const const_580: String = "WE_RELOCATE";

        public static const const_1033: String = "WE_RELOCATED";

        public static const const_801: String = "WE_RESIZE";

        public static const const_767: String = "WE_RESIZED";

        public static const const_1097: String = "WE_MINIMIZE";

        public static const const_1193: String = "WE_MINIMIZED";

        public static const const_585: String = "WE_MAXIMIZE";

        public static const const_652: String = "WE_MAXIMIZED";

        public static const WINDOW_EVENT_RESTORE: String = "WE_RESTORE";

        public static const const_1149: String = "WE_RESTORED";

        public static const const_838: String = "WE_EXPANDED";

        public static const const_1142: String = "WE_COLLAPSE";

        public static const const_674: String = "WE_CHILD_ADDED";

        public static const const_774: String = "WE_CHILD_REMOVED";

        public static const const_944: String = "WE_CHILD_RELOCATED";

        public static const const_534: String = "WE_CHILD_RESIZED";

        public static const const_1173: String = "WE_CHILD_ACTIVATED";

        public static const const_1066: String = "WE_CHILD_VISIBILITY";

        public static const const_688: String = "WE_PARENT_ADDED";

        public static const const_775: String = "WE_PARENT_REMOVED";

        public static const const_683: String = "WE_PARENT_RELOCATED";

        public static const const_998: String = "WE_PARENT_RESIZED";

        public static const const_734: String = "WE_PARENT_ACTIVATED";

        public static const const_755: String = "WE_OK";

        public static const const_664: String = "WE_CANCEL";

        public static const WINDOW_EVENT_CHANGE: String = "WE_CHANGE";

        public static const const_521: String = "WE_SCROLL";

        public static const UNKNOWN: String = "";

        private static const const_422: Array = [];

        protected var var_329: String;

        protected var _window: IWindow;

        protected var var_2724: IWindow;

        protected var var_2416: Boolean;

        protected var var_2351: Boolean;

        protected var var_1708: Boolean;

        protected var var_2969: Array;

        public function WindowEvent() {
            super();
        }

        public static function allocate(param1: String, param2: IWindow, param3: IWindow, param4: Boolean = false): WindowEvent {
            var _loc5_: WindowEvent;
            (_loc5_ = const_422.length > 0 ? const_422.pop() : new WindowEvent()).var_329 = param1;
            _loc5_._window = param2;
            _loc5_.var_2724 = param3;
            _loc5_.var_2351 = param4;
            _loc5_.var_1708 = false;
            _loc5_.var_2969 = const_422;
            return _loc5_;
        }

        public function get type(): String {
            return var_329;
        }

        public function get target(): IWindow {
            return _window;
        }

        public function get window(): IWindow {
            return _window;
        }

        public function get related(): IWindow {
            return var_2724;
        }

        public function get cancelable(): Boolean {
            return var_2351;
        }

        public function recycle(): void {
            if (var_1708) {
                throw new Error("Event already recycled!");
            }
            _window = var_2724 = null;
            var_1708 = true;
            var_2416 = false;
            var_2969.push(this);
        }

        public function clone(): WindowEvent {
            return allocate(var_329, window, related, cancelable);
        }

        public function preventDefault(): void {
            preventWindowOperation();
        }

        public function isDefaultPrevented(): Boolean {
            return var_2416;
        }

        public function preventWindowOperation(): void {
            if (cancelable) {
                var_2416 = true;
                return;
            }
            throw new Error("Attempted to prevent window operation that is not cancelable!");
        }

        public function isWindowOperationPrevented(): Boolean {
            return var_2416;
        }

        public function stopPropagation(): void {
            var_2416 = true;
        }

        public function stopImmediatePropagation(): void {
            var_2416 = true;
        }

        public function toString(): String {
            return "WindowEvent { type: " + var_329 + " cancelable: " + var_2351 + " window: " + _window + " }";
        }
    }
}
