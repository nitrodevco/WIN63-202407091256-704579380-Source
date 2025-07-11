package com.sulake.core.window {
    import com.sulake.core.assets.IResourceManager
    import com.sulake.core.localization.ICoreLocalizationManager
    import com.sulake.core.localization.ILocalizable
    import com.sulake.core.runtime.ICoreConfiguration
    import com.sulake.core.runtime.IDisposable
    import com.sulake.core.runtime.IUpdateReceiver
    import com.sulake.core.runtime.events.ILinkEventTracker
    import com.sulake.core.window.components.DesktopController
    import com.sulake.core.window.components.SubstituteParentController
    import com.sulake.core.window.components.class_3460
    import com.sulake.core.window.graphics.IGraphicContextHost
    import com.sulake.core.window.graphics.class_3354
    import com.sulake.core.window.services.IInternalWindowServices
    import com.sulake.core.window.services.ServiceManager
    import com.sulake.core.window.utils.EventProcessorState
    import com.sulake.core.window.utils.IEventProcessor
    import com.sulake.core.window.utils.IEventQueue
    import com.sulake.core.window.utils.MouseEventProcessor
    import com.sulake.core.window.utils.MouseEventQueue
    import com.sulake.core.window.utils.WindowParser
    import com.sulake.core.window.utils.class_3577
    import com.sulake.core.window.utils.tablet.TabletEventProcessor
    import com.sulake.core.window.utils.tablet.TabletEventQueue

    import flash.display.DisplayObject
    import flash.display.DisplayObjectContainer
    import flash.display.Stage
    import flash.events.Event
    import flash.geom.Rectangle

    public class WindowContext implements class_3400, IDisposable, IUpdateReceiver {

        public static const INPUT_MODE_MOUSE: uint = 0;

        public static const INPUT_MODE_TOUCH: uint = 1;

        public static const ERROR_UNKNOWN: int = 0;

        public static const ERROR_INVALID_WINDOW: int = 1;

        public static const ERROR_WINDOW_NOT_FOUND: int = 2;

        public static const ERROR_WINDOW_ALREADY_EXISTS: int = 3;

        public static const ERROR_UNKNOWN_WINDOW_TYPE: int = 4;

        public static const ERROR_DURING_EVENT_HANDLING: int = 5;

        public static var inputEventQueue: IEventQueue;

        private static var inputEventProcessor: IEventProcessor;

        private static var inputModeFlag: uint = 0;

        private static var var_1836: class_3354;

        private static var stage: Stage;

        public var inputEventTrackers: Vector.<IInputEventTracker>;

        private var _linkEventTrackers: Vector.<ILinkEventTracker>;

        private var var_4604: EventProcessorState;

        protected var _localization: ICoreLocalizationManager;

        protected var _rootDisplayObject: DisplayObjectContainer;

        protected var _throwErrors: Boolean = true;

        protected var _lastError: Error;

        protected var var_3613: int = -1;

        protected var var_3190: IInternalWindowServices;

        protected var var_3528: class_3577;

        protected var var_3799: class_1799;

        protected var var_3890: class_1798;

        protected var var_2890: IResourceManager;

        protected var var_1750: class_3460;

        protected var var_3572: SubstituteParentController;

        private var _disposed: Boolean = false;

        private var var_1896: Boolean = false;

        private var _rendering: Boolean = false;

        private var _name: String;

        private var var_209: ICoreConfiguration;

        public function WindowContext(param1: String, param2: class_3354, param3: class_1799, param4: class_1798, param5: IResourceManager, param6: ICoreLocalizationManager, param7: ICoreConfiguration, param8: DisplayObjectContainer, param9: Rectangle, param10: Vector.<ILinkEventTracker>) {
            super();
            _name = param1;
            var_1836 = param2;
            _localization = param6;
            var_209 = param7;
            _rootDisplayObject = param8;
            var_3190 = new ServiceManager(this, param8);
            var_3799 = param3;
            var_3890 = param4;
            var_2890 = param5;
            var_3528 = new WindowParser(this);
            inputEventTrackers = new Vector.<IInputEventTracker>(0);
            _linkEventTrackers = param10;
            if (!stage) {
                if (_rootDisplayObject is Stage) {
                    stage = _rootDisplayObject as Stage;
                } else if (_rootDisplayObject.stage) {
                    stage = _rootDisplayObject.stage;
                }
            }
            Classes.init();
            if (param9 == null) {
                param9 = new Rectangle(0, 0, 800, 600);
            }
            var_1750 = new DesktopController("_CONTEXT_DESKTOP_" + _name, this, param9);
            var_1750.limits.maxWidth = param9.width;
            var_1750.limits.maxHeight = param9.height;
            _rootDisplayObject.addChild(var_1750.getDisplayObject());
            _rootDisplayObject.doubleClickEnabled = true;
            _rootDisplayObject.addEventListener("resize", stageResizedHandler);
            var_4604 = new EventProcessorState(var_1836, var_1750, var_1750, null, null, null, inputEventTrackers);
            inputMode = 0;
            var_3572 = new SubstituteParentController(this);
        }

        public static function get inputMode(): uint {
            return inputModeFlag;
        }

        public static function set inputMode(param1: uint): void {
            if (inputEventQueue) {
                if (inputEventQueue is IDisposable) {
                    IDisposable(inputEventQueue).dispose();
                }
            }
            if (inputEventProcessor) {
                if (inputEventProcessor is IDisposable) {
                    IDisposable(inputEventProcessor).dispose();
                }
            }
            switch (param1) {
                case INPUT_MODE_MOUSE:
                    inputEventQueue = new MouseEventQueue(stage);
                    inputEventProcessor = new MouseEventProcessor();
                    try {
                    } catch (e: Error) {
                    }
                    break;
                case 1:
                    inputEventQueue = new TabletEventQueue(stage);
                    inputEventProcessor = new TabletEventProcessor();
                    try {
                    } catch (e: Error) {
                    }
                    break;
                default:
                    inputMode = INPUT_MODE_MOUSE;
                    throw new Error("Unknown input mode " + param1);
            }
        }

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function dispose(): void {
            if (!_disposed) {
                _disposed = true;
                _rootDisplayObject.removeEventListener("resize", stageResizedHandler);
                _rootDisplayObject.removeChild(IGraphicContextHost(var_1750).getGraphicContext(true) as DisplayObject);
                var_1750.destroy();
                var_1750 = null;
                var_3572.destroy();
                var_3572 = null;
                if (var_3190 is IDisposable) {
                    IDisposable(var_3190).dispose();
                }
                var_3190 = null;
                var_3528.dispose();
                var_3528 = null;
                var_1836 = null;
                _localization = null;
                _rootDisplayObject = null;
                var_3799 = null;
                var_3890 = null;
                var_2890 = null;
            }
        }

        public function getLastError(): Error {
            return _lastError;
        }

        public function getLastErrorCode(): int {
            return var_3613;
        }

        public function handleError(param1: int, param2: Error): void {
            _lastError = param2;
            var_3613 = param1;
            if (_throwErrors) {
                throw param2;
            }
        }

        public function flushError(): void {
            _lastError = null;
            var_3613 = -1;
        }

        public function getWindowServices(): IInternalWindowServices {
            return var_3190;
        }

        public function getWindowParser(): class_3577 {
            return var_3528;
        }

        public function getWindowFactory(): class_1799 {
            return var_3799;
        }

        public function getDesktopWindow(): class_3460 {
            return var_1750;
        }

        public function findWindowByName(param1: String): IWindow {
            return var_1750.findChildByName(param1);
        }

        public function findWindowByTag(param1: String): IWindow {
            return var_1750.findChildByTag(param1);
        }

        public function groupChildrenWithTag(param1: String, param2: Array, param3: int = 0): uint {
            return var_1750.groupChildrenWithTag(param1, param2, param3);
        }

        public function registerLocalizationListener(param1: String, param2: IWindow): void {
            _localization.registerListener(param1, param2 as ILocalizable);
        }

        public function removeLocalizationListener(param1: String, param2: IWindow): void {
            _localization.removeListener(param1, param2 as ILocalizable);
        }

        public function create(param1: String, param2: String, param3: uint, param4: uint, param5: uint, param6: Rectangle, param7: Function, param8: IWindow, param9: uint, param10: Array = null, param11: String = "", param12: Array = null): IWindow {
            var _loc14_: IWindow = null;
            var _loc13_: Class;
            if ((_loc13_ = Classes.getWindowClassByType(param3)) == null) {
                handleError(4, new Error("Failed to solve implementation for window \"" + param1 + "\"!"));
                return null;
            }
            if (param8 == null) {
                if (param5 & 16) {
                    param8 = var_3572;
                }
            }
            (_loc14_ = new _loc13_(param1, param3, param4, param5, this, param6, param8 != null ? param8 : var_1750, param7, param10, param12, param9)).dynamicStyle = param11;
            if (param2 && param2.length) {
                _loc14_.caption = param2;
            }
            return _loc14_;
        }

        public function destroy(param1: IWindow): Boolean {
            if (param1 == var_1750) {
                var_1750 = null;
            }
            if (param1.state != 1073741824) {
                param1.destroy();
            }
            return true;
        }

        public function invalidate(param1: IWindow, param2: Rectangle, param3: uint): void {
            if (!disposed) {
                var_1836.addToRenderQueue(param1, param2, param3);
            }
        }

        public function update(param1: uint): void {
            var _loc2_: Error = null;
            var_1896 = true;
            if (_lastError) {
                _loc2_ = _lastError;
                _lastError = null;
                throw _loc2_;
            }
            inputEventProcessor.process(var_4604, inputEventQueue);
            var_1896 = false;
        }

        public function render(param1: uint): void {
            _rendering = true;
            var_1836.render();
            _rendering = false;
        }

        private function stageResizedHandler(param1: Event): void {
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            if (var_1750 != null && !var_1750.disposed) {
                if (_rootDisplayObject is Stage) {
                    _loc2_ = int(Stage(_rootDisplayObject).stageWidth);
                    _loc3_ = int(Stage(_rootDisplayObject).stageHeight);
                } else {
                    _loc2_ = _rootDisplayObject.width;
                    _loc3_ = _rootDisplayObject.height;
                }
                if (_loc2_ >= 10 && _loc3_ >= 10) {
                    var_1750.limits.maxWidth = _loc2_;
                    var_1750.limits.maxHeight = _loc3_;
                    var_1750.width = _loc2_;
                    var_1750.height = _loc3_;
                }
            }
        }

        public function addMouseEventTracker(param1: IInputEventTracker): void {
            if (inputEventTrackers.indexOf(param1) < 0) {
                inputEventTrackers.push(param1);
            }
        }

        public function removeMouseEventTracker(param1: IInputEventTracker): void {
            var _loc2_: int = inputEventTrackers.indexOf(param1);
            if (_loc2_ > -1) {
                inputEventTrackers.splice(_loc2_, 1);
            }
        }

        public function getResourceManager(): IResourceManager {
            return var_2890;
        }

        public function getWidgetFactory(): class_1798 {
            return var_3890;
        }

        public function get linkEventTrackers(): Vector.<ILinkEventTracker> {
            return _linkEventTrackers;
        }
    }
}
