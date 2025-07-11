package com.sulake.core.window.components {
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.class_3420;
    import com.sulake.core.window.utils.IIterable;

    public interface IWidgetWindow extends IWindow, IIterable {

        function get widget(): class_3420;

        function get rootWindow(): IWindow;

        function set rootWindow(param1: IWindow): void;
    }
}
