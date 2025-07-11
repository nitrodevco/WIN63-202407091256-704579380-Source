package com.sulake.habbo.window {
    import assets.class_14;

    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.IResourceManager;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IIDProfiler;
    import com.sulake.core.runtime.IProfiler;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.utils.Map;
    import com.sulake.core.utils.class_285;
    import com.sulake.core.utils.profiler.ProfilerAgentTask;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IInputEventTracker;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.class_1798;
    import com.sulake.core.window.class_1799;
    import com.sulake.core.window.class_3400;
    import com.sulake.core.window.class_3420;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.components.class_3460;
    import com.sulake.core.window.components.class_3514;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.graphics.SkinContainer;
    import com.sulake.core.window.graphics.WindowRenderer;
    import com.sulake.core.window.graphics.class_3354;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.theme.IThemeManager;
    import com.sulake.core.window.tools.*;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.utils.INotify;
    import com.sulake.core.window.utils.MouseCursorControl;
    import com.sulake.core.window.utils.class_3348;
    import com.sulake.core.window.utils.class_3401;
    import com.sulake.core.window.utils.class_3441;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.window.handlers.HabbletLinkHandler;
    import com.sulake.habbo.window.theme.ThemeManager;
    import com.sulake.habbo.window.utils.AlertDialog;
    import com.sulake.habbo.window.utils.AlertDialogWithLink;
    import com.sulake.habbo.window.utils.ConfirmDialog;
    import com.sulake.habbo.window.utils.ElementPointerHandler;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.habbo.window.utils.ModalDialog;
    import com.sulake.habbo.window.utils.SimpleAlertDialog;
    import com.sulake.habbo.window.utils.class_3503;
    import com.sulake.habbo.window.utils.floorplaneditor.BCFloorPlanEditor;
    import com.sulake.habbo.window.utils.habbopedia.HabboPagesViewer;
    import com.sulake.habbo.window.widgets.class_3474;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDSessionDataManager;

    import flash.events.Event;
    import flash.external.ExternalInterface;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.text.StyleSheet;
    import flash.utils.getTimer;

    public class HabboWindowManagerComponent extends Component implements IHabboWindowManager, ICoreWindowManager, class_1799, IUpdateReceiver, IInputEventTracker, class_1798 {

        private static const TRACKING_EVENT_INPUT: Event = new Event("HABBO_WINDOW_TRACKING_EVENT_INPUT");
        private static const TRACKING_EVENT_RENDER: Event = new Event("HABBO_WINDOW_TRACKING_EVENT_RENDER");
        private static const TRACKING_EVENT_SLEEP: Event = new Event("HABBO_WINDOW_TRACKING_EVENT_SLEEP");
        private static const NUMBER_OF_CONTEXT_LAYERS: uint = 4;
        private static const DEFAULT_CONTEXT_LAYER_INDEX: uint = 1;

        private var _localization: IHabboLocalizationManager;
        private var _windowContextArray: Array;
        private var _activeWindowContext: class_3400;
        private var _windowRenderer: class_3354;
        private var _skinContainer: SkinContainer;
        private var _initialized: Boolean = false;
        private var _profilerOutput: ProfilerOutput;
        private var _profilerAgentTaskUpdate: ProfilerAgentTask;
        private var _profilerAgentTaskRedraw: ProfilerAgentTask;
        private var _themeManager: ThemeManager;
        private var _resourceManager: ResourceManager;
        private var _hintManager: HintManager;
        private var _avatarRenderer: IAvatarRenderManager;
        private var _communication: IHabboCommunicationManager;
        private var _sessionDataManager: ISessionDataManager;
        private var _roomEngine: IRoomEngine;
        private var _bcfloorPlanEditor: BCFloorPlanEditor;
        private var _habboPagesViewer: HabboPagesViewer;
        private var _habbletLinkHandler: HabbletLinkHandler;
        private var _elementPointerHandler: ElementPointerHandler;

        public function HabboWindowManagerComponent(context: IContext, flags: uint = 0, assetLibrary: IAssetLibrary = null) {
            super(context, flags, assetLibrary);
            class_285.refresh();
            HTMLTextController.defaultLinkTarget = "habboMain";
        }

        public function get roomEngine(): IRoomEngine {
            return _roomEngine;
        }

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[
                new ComponentDependency(new IIDSessionDataManager(), function (manager: ISessionDataManager): void {
                    _sessionDataManager = manager;
                }, false),
                new ComponentDependency(new IIDHabboLocalizationManager(), function (localization: IHabboLocalizationManager): void {
                    _localization = localization;
                }),
                new ComponentDependency(new IIDHabboConfigurationManager(), function (config: ICoreConfiguration): void {
                }, false, [{
                    "type": "complete",
                    "callback": onConfigurationComplete
                }]),
                new ComponentDependency(new IIDAvatarRenderManager(), function (renderer: IAvatarRenderManager): void {
                    _avatarRenderer = renderer;
                }, false),
                new ComponentDependency(new IIDHabboCommunicationManager(), setCommunicationManager, false),
                new ComponentDependency(new IIDRoomEngine(), function (engine: IRoomEngine): void {
                    _roomEngine = engine;
                }, false)
            ]);
        }

        private function setCommunicationManager(manager: IHabboCommunicationManager): void {
            _communication = manager;
        }

        private function onConfigurationComplete(event: Event): void {
            if (_communication != null) {
                _bcfloorPlanEditor = new BCFloorPlanEditor(this);
                _elementPointerHandler = new ElementPointerHandler(this);
            }
        }

        override protected function initComponent(): void {
            try {
                var startTime: int = getTimer();
                var asset: IAsset = this.findAssetByName("habbo_element_description_xml");
                _skinContainer = new SkinContainer();
                class_3503.parse(asset.content as XML, assets, _skinContainer);
                _themeManager = new ThemeManager(_skinContainer);
                _resourceManager = new ResourceManager(this);
                _hintManager = new HintManager(this);
                _windowRenderer = new WindowRenderer(_skinContainer);
                _windowContextArray = new Array(NUMBER_OF_CONTEXT_LAYERS);
                var stageBounds: Rectangle = new Rectangle(0, 0, context.displayObjectContainer.stage.stageWidth, context.displayObjectContainer.stage.stageHeight);

                for (var i: int = 0; i < NUMBER_OF_CONTEXT_LAYERS; i++) {
                    _windowContextArray[i] = new WindowContext("layer_" + i, _windowRenderer, this, this, _resourceManager, _localization, this, context.displayObjectContainer, stageBounds, context.linkEventTrackers);
                }

                this.removeAsset(asset);
                asset.dispose();
                _activeWindowContext = _windowContextArray[DEFAULT_CONTEXT_LAYER_INDEX];
                addMouseEventTracker(this);
                registerUpdateReceiver(this, 0);
                queueInterface(new IIDProfiler(), receiveProfilerInterface);

                var elapsedTime: int = getTimer() - startTime;
                class_14.log("initializing window framework took " + elapsedTime + "ms");
                _initialized = true;
                _habboPagesViewer = new HabboPagesViewer(this);
                _habbletLinkHandler = new HabbletLinkHandler(this);
                context.addLinkEventTracker(_habbletLinkHandler);

                if (ExternalInterface.available) {
                    ExternalInterface.addCallback("openlink", context.createLinkEvent);
                }
            } catch (e: Error) {
                trace("Error initializing window framework: ", e);
                trace("Stack trace: ", e.getStackTrace());
                throw e;
            }
        }

        public function toggleFullScreen(): void {
            var stage = context.displayObjectContainer.stage;
            if (stage.displayState == "fullScreenInteractive") {
                stage.displayState = "normal";
            } else {
                stage.displayState = "fullScreenInteractive";
            }
        }

        private function receiveProfilerInterface(iid: IID, unknown: IUnknown): void {
            var profiler: IProfiler = unknown as IProfiler;
            if (profiler != null) {
                if (!_profilerOutput) {
                    _profilerOutput = new ProfilerOutput(context, this, _windowRenderer);
                }
                _profilerOutput.profiler = profiler;
                _profilerAgentTaskUpdate = new ProfilerAgentTask("Update", "Event processing");
                profiler.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskUpdate);
                _profilerAgentTaskRedraw = new ProfilerAgentTask("Redraw", "Window rasterizer");
                profiler.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskRedraw);
            }
        }

        override public function dispose(): void {
            if (!disposed) {
                disposeLinkHandlers();
                removeUpdateReceiver(this);
                disposeEditors();
                disposeWindowContexts();
                disposeRenderer();
                disposeManagers();
                super.dispose();
            }
        }

        private function disposeLinkHandlers(): void {
            if (_habbletLinkHandler != null) {
                context.removeLinkEventTracker(_habbletLinkHandler);
                _habbletLinkHandler.dispose();
                _habbletLinkHandler = null;
            }
            if (_elementPointerHandler != null) {
                _elementPointerHandler.dispose();
                _elementPointerHandler = null;
            }
        }

        private function disposeEditors(): void {
            if (_bcfloorPlanEditor != null) {
                _bcfloorPlanEditor.dispose();
                _bcfloorPlanEditor = null;
            }
            if (_habboPagesViewer != null) {
                _habboPagesViewer.dispose();
                _habboPagesViewer = null;
            }
        }

        private function disposeWindowContexts(): void {
            if (_windowContextArray) {
                while (_windowContextArray.length > 0) {
                    IDisposable(_windowContextArray.pop()).dispose();
                }
            }
            _windowContextArray = null;
        }

        private function disposeRenderer(): void {
            if (_windowRenderer) {
                _windowRenderer.dispose();
                _windowRenderer = null;
            }
            if (_skinContainer) {
                _skinContainer.dispose();
                _skinContainer = null;
            }
        }

        private function disposeManagers(): void {
            if (_resourceManager != null) {
                _resourceManager.dispose();
                _resourceManager = null;
            }
            if (_hintManager != null) {
                _hintManager.dispose();
                _hintManager = null;
            }
        }

        public function create(name: String, type: uint, param3: uint, param4: uint, bounds: Rectangle, param6: Function = null, param7: String = "", param8: uint = 0, param9: Array = null, parent: IWindow = null, param11: Array = null, param12: String = ""): IWindow {
            return _activeWindowContext.create(name, param7, type, param3, param4, bounds, param6, parent, param8, param11, param12, param9);
        }

        public function destroy(window: IWindow): void {
            window.destroy();
        }

        public function buildFromXML(xml: XML, contextLayer: uint = 1, map: Map = null): IWindow {
            var window: IWindow = getWindowContext(contextLayer).getWindowParser().parseAndConstruct(xml, null, map);
            if (window is class_3514) {
                class_3514(window).helpButtonAction = openHelpPage;
            }
            return window;
        }

        public function windowToXMLString(window: IWindow): String {
            return _activeWindowContext.getWindowParser().windowToXMLString(window);
        }

        public function getLayoutByTypeAndStyle(type: uint, style: uint): XML {
            return _skinContainer.getWindowLayoutByTypeAndStyle(type, style);
        }

        public function getDefaultsByTypeAndStyle(type: uint, style: uint): DefaultAttStruct {
            return _skinContainer.getDefaultAttributesByTypeAndStyle(type, style);
        }

        public function getRendererByTypeAndStyle(type: uint, style: uint): ISkinRenderer {
            return _skinContainer.getSkinRendererByTypeAndStyle(type, style);
        }

        public function createWindow(name: String, caption: String = "", type: uint = 0, param4: uint = 0, param5: uint = 0, bounds: Rectangle = null, param7: Function = null, param8: uint = 0, contextLayer: uint = 1, param10: String = ""): IWindow {
            return _windowContextArray[contextLayer].create(name, caption, type, param4, param5, bounds, param7, null, param8, null, null, null);
        }

        public function removeWindow(name: String, contextLayer: uint = 1): void {
            var desktop: class_3460 = _windowContextArray[contextLayer].getDesktopWindow();
            var window: IWindow = desktop.getChildByName(name);
            if (window != null) {
                window.destroy();
            }
        }

        public function getWindowByName(name: String, contextLayer: uint = 1): IWindow {
            return _windowContextArray[contextLayer].getDesktopWindow().getChildByName(name);
        }

        public function getActiveWindow(contextLayer: uint = 1): IWindow {
            var desktop = _windowContextArray[contextLayer].getDesktopWindow();
            return desktop.getChildAt(_activeWindowContext.getDesktopWindow().numChildren - 1);
        }

        public function getWindowContext(contextLayer: uint): class_3400 {
            return _windowContextArray[contextLayer];
        }

        public function getDesktop(contextLayer: uint): class_3460 {
            var context = _windowContextArray[contextLayer];
            return context ? context.getDesktopWindow() : null;
        }

        public function notify(title: String, message: String, callback: Function, flags: uint = 0): INotify {
            var asset = this.findAssetByName("habbo_window_alert_xml");
            if (!asset) {
                throw new Error("Failed to initialize alert dialog; missing asset!");
            }
            var xml: XML = asset.content as XML;
            return new AlertDialog(this, xml, title, message, flags, callback, false);
        }

        public function alert(title: String, message: String, flags: uint, callback: Function): class_3348 {
            var asset = this.findAssetByName("habbo_window_alert_xml");
            if (!asset) {
                throw new Error("Failed to initialize alert dialog; missing asset!");
            }
            var xml: XML = asset.content as XML;
            return new AlertDialog(this, xml, title, message, flags, callback, false);
        }

        public function alertWithModal(title: String, message: String, flags: uint, callback: Function): class_3348 {
            var asset = this.findAssetByName("habbo_window_alert_xml");
            if (!asset) {
                throw new Error("Failed to initialize alert dialog; missing asset!");
            }
            var xml: XML = asset.content as XML;
            return new AlertDialog(this, xml, title, message, flags, callback, true);
        }

        public function alertWithLink(title: String, message: String, linkTitle: String, linkUrl: String, flags: uint, callback: Function): class_3401 {
            var asset = this.findAssetByName("habbo_window_alert_link_xml");
            if (!asset) {
                throw new Error("Failed to initialize alert dialog; missing asset!");
            }
            var xml: XML = asset.content as XML;
            return new AlertDialogWithLink(this, xml, title, message, linkTitle, linkUrl, flags, callback);
        }

        public function confirm(title: String, message: String, flags: uint, callback: Function): class_3441 {
            var asset = this.findAssetByName("habbo_window_confirm_xml");
            if (!asset) {
                throw new Error("Failed to initialize alert dialog; missing asset!");
            }
            var xml: XML = asset.content as XML;
            return new ConfirmDialog(this, xml, title, message, flags, callback, false);
        }

        public function confirmWithModal(title: String, message: String, flags: uint, callback: Function): class_3441 {
            var asset = this.findAssetByName("habbo_window_confirm_xml");
            if (!asset) {
                throw new Error("Failed to initialize alert dialog; missing asset!");
            }
            var xml: XML = asset.content as XML;
            return new ConfirmDialog(this, xml, title, message, flags, callback, true);
        }

        public function registerLocalizationParameter(key: String, value: String, context: String, delimiter: String = "%"): void {
            _localization.registerParameter(key, value, context, delimiter);
        }

        public function update(deltaTime: uint): void {
            var i: int;

            if (_profilerAgentTaskUpdate) {
                _profilerAgentTaskUpdate.start();
            }

            if (WindowContext.inputEventQueue.length > 0) {
                events.dispatchEvent(TRACKING_EVENT_INPUT);

                for (i = NUMBER_OF_CONTEXT_LAYERS - 1; i >= 0; i--) {
                    _windowContextArray[i].update(deltaTime);
                }
            }

            if (_profilerAgentTaskUpdate) {
                _profilerAgentTaskUpdate.stop();
            }

            if (_profilerAgentTaskRedraw) {
                _profilerAgentTaskRedraw.start();
            }

            events.dispatchEvent(TRACKING_EVENT_RENDER);

            for (i = 0; i < NUMBER_OF_CONTEXT_LAYERS; i++) {
                _windowContextArray[i].render(deltaTime);
            }

            if (_profilerAgentTaskRedraw) {
                _profilerAgentTaskRedraw.stop();
            }

            if (WindowContext.inputEventQueue.length > 0) {
                WindowContext.inputEventQueue.flush();
            }

            MouseCursorControl.change();
            events.dispatchEvent(TRACKING_EVENT_SLEEP);
        }

        override public function purge(): void {
            super.purge();
            if (_windowRenderer) {
                _windowRenderer.purge();
            }
        }

        public function addMouseEventTracker(tracker: IInputEventTracker): void {
            for each (var context in _windowContextArray) {
                context.addMouseEventTracker(tracker);
            }
        }

        public function removeMouseEventTracker(tracker: IInputEventTracker): void {
            for each (var context in _windowContextArray) {
                context.removeMouseEventTracker(tracker);
            }
        }

        public function eventReceived(event: WindowEvent, window: IWindow): void {
            if (window != null) {
                if (event.type == "WME_CLICK") {
                    ErrorReportStorage.setParameter("click_time", new Date().getTime().toString());
                    ErrorReportStorage.setParameter("click_target", window.name + ": " + window.toString());
                } else if (event.type == "WME_UP") {
                    ErrorReportStorage.setParameter("mouse_up_time", new Date().getTime().toString());
                    ErrorReportStorage.setParameter("mouse_up_target", window.name + ": " + window.toString());
                }
            }
        }

        private function performTestCases(): void {
            class_14.log("type: " + Capabilities.playerType + " debugger: " + Capabilities.isDebugger + " version: " + Capabilities.version);
        }

        public function findWindowByName(name: String): IWindow {
            var window: IWindow;

            for each (var context in _windowContextArray) {
                window = context.findWindowByName(name);
                if (window) {
                    return window;
                }
            }

            return null;
        }

        public function findWindowByTag(tag: String): IWindow {
            var window: IWindow;

            for each (var context in _windowContextArray) {
                window = context.findWindowByTag(tag);
                if (window) {
                    return window;
                }
            }

            return null;
        }

        public function groupWindowsWithTag(tag: String, windows: Array, contextLayer: int = 0): uint {
            var count: uint = 0;

            for each (var context in _windowContextArray) {
                count += context.groupChildrenWithTag(tag, windows, contextLayer);
            }

            return count;
        }

        public function getThemeManager(): IThemeManager {
            return _themeManager;
        }

        public function createUnseenItemCounter(): IWindowContainer {
            var asset: IAsset = this.findAssetByName("unseen_item_counter_xml");
            var xml: XML = asset.content as XML;
            return buildFromXML(xml) as IWindowContainer;
        }

        public function createWidget(type: String, window: IWidgetWindow): class_3420 {
            var widgetClass: Class = class_3474.var_1728[type];

            if (widgetClass != null) {
                return new widgetClass(window, this);
            }

            throw new Error("Unknown widget type " + type + "! You might need to update Glaze to be able to work on this layout.");
        }

        public function get avatarRenderer(): IAvatarRenderManager {
            return _avatarRenderer;
        }

        public function get resourceManager(): IResourceManager {
            return _resourceManager;
        }

        public function get localization(): IHabboLocalizationManager {
            return _localization;
        }

        public function buildModalDialogFromXML(xml: XML): IModalDialog {
            return new ModalDialog(this, xml);
        }

        public function get communication(): IHabboCommunicationManager {
            return _communication;
        }

        public function get sessionDataManager(): ISessionDataManager {
            return _sessionDataManager;
        }

        public function simpleAlert(title: String, message: String, param3: String, param4: String = null, param5: String = null, param6: Map = null, param7: String = null, param8: Function = null, param9: Function = null): void {
            new SimpleAlertDialog(this, title, message, param3, param4, param5, param6, param7, param8, param9);
        }

        public function registerHintWindow(name: String, window: IWindow, contextLayer: int = 1): void {
            _hintManager.registerWindow(name, window, contextLayer);
        }

        public function unregisterHintWindow(name: String): void {
            _hintManager.unregisterWindow(name);
        }

        public function showHint(name: String, bounds: Rectangle = null): void {
            _hintManager.showHint(name, bounds);
        }

        public function hideHint(): void {
            _hintManager.hideHint();
        }

        public function hideMatchingHint(name: String): void {
            _hintManager.hideMatchingHint(name);
        }

        public function displayFloorPlanEditor(): void {
            if (_bcfloorPlanEditor == null) {
                _bcfloorPlanEditor = new BCFloorPlanEditor(this);
            }
            if (_bcfloorPlanEditor != null) {
                _bcfloorPlanEditor.visible = true;
            }
        }

        public function openHelpPage(page: String): void {
            if (_habboPagesViewer != null) {
                _habboPagesViewer.openPage(page);
            }
        }

        public function get habboPagesStyleSheet(): StyleSheet {
            return HabboPagesViewer.styleSheet;
        }
    }
}
