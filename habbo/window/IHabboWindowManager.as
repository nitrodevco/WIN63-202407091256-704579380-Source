package com.sulake.habbo.window {
    import com.sulake.core.assets.IResourceManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IInputEventTracker;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.class_3400;
    import com.sulake.core.window.utils.class_3348;
    import com.sulake.core.window.utils.class_3401;
    import com.sulake.habbo.window.utils.IModalDialog;

    import flash.geom.Rectangle;
    import flash.text.StyleSheet;

    public interface IHabboWindowManager extends IUnknown, ICoreWindowManager {

        function createWindow(param1: String, param2: String = "", param3: uint = 0, param4: uint = 0, param5: uint = 0, param6: Rectangle = null, param7: Function = null, param8: uint = 0, param9: uint = 1, param10: String = ""): IWindow;

        function removeWindow(param1: String, param2: uint = 1): void;

        function getWindowByName(param1: String, param2: uint = 1): IWindow;

        function getActiveWindow(param1: uint = 1): IWindow;

        function toggleFullScreen(): void;

        function getWindowContext(param1: uint): class_3400;

        function alert(param1: String, param2: String, param3: uint, param4: Function): class_3348;

        function alertWithModal(param1: String, param2: String, param3: uint, param4: Function): class_3348;

        function alertWithLink(param1: String, param2: String, param3: String, param4: String, param5: uint, param6: Function): class_3401;

        function registerLocalizationParameter(param1: String, param2: String, param3: String, param4: String = "%"): void;

        function addMouseEventTracker(param1: IInputEventTracker): void;

        function removeMouseEventTracker(param1: IInputEventTracker): void;

        function createUnseenItemCounter(): IWindowContainer;

        function get resourceManager(): IResourceManager;

        function buildModalDialogFromXML(param1: XML): IModalDialog;

        function simpleAlert(param1: String, param2: String, param3: String, param4: String = null, param5: String = null, param6: Map = null, param7: String = null, param8: Function = null, param9: Function = null): void;

        function get assets(): IAssetLibrary;

        function registerHintWindow(param1: String, param2: IWindow, param3: int = 1): void;

        function unregisterHintWindow(param1: String): void;

        function showHint(param1: String, param2: Rectangle = null): void;

        function hideHint(): void;

        function displayFloorPlanEditor(): void;

        function openHelpPage(param1: String): void;

        function get habboPagesStyleSheet(): StyleSheet;

        function hideMatchingHint(param1: String): void;
    }
}
