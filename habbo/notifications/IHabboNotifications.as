package com.sulake.habbo.notifications {
    import com.sulake.core.runtime.IUnknown
    import com.sulake.core.utils.Map

    public interface IHabboNotifications extends IUnknown {

        function addItem(param1: String, param2: String, param3: String = null): void;

        function showNotification(param1: String, param2: Map = null): void;

        function addSongPlayingNotification(param1: String, param2: String): void;
    }
}
