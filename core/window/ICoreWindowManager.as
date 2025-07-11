package com.sulake.core.window {
    import com.sulake.core.utils.Map
    import com.sulake.core.window.components.class_3460
    import com.sulake.core.window.utils.INotify
    import com.sulake.core.window.utils.class_3441

    import flash.geom.Rectangle

    public interface ICoreWindowManager {

        function create(param1: String, param2: uint, param3: uint, param4: uint, param5: Rectangle, param6: Function = null, param7: String = "", param8: uint = 0, param9: Array = null, param10: IWindow = null, param11: Array = null, param12: String = ""): IWindow;

        function destroy(param1: IWindow): void;

        function buildFromXML(param1: XML, param2: uint = 1, param3: Map = null): IWindow;

        function windowToXMLString(param1: IWindow): String;

        function getDesktop(param1: uint): class_3460;

        function notify(param1: String, param2: String, param3: Function, param4: uint = 0): INotify;

        function confirm(param1: String, param2: String, param3: uint, param4: Function): class_3441;

        function confirmWithModal(param1: String, param2: String, param3: uint, param4: Function): class_3441;

        function findWindowByName(param1: String): IWindow;

        function findWindowByTag(param1: String): IWindow;

        function groupWindowsWithTag(param1: String, param2: Array, param3: int = 0): uint;
    }
}
