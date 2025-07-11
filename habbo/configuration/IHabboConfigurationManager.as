package com.sulake.habbo.configuration {
    import com.sulake.core.runtime.ICoreConfiguration

    import flash.events.IEventDispatcher

    public interface IHabboConfigurationManager extends ICoreConfiguration {

        function isInitialized(): Boolean;

        function updateEnvironmentId(param1: String): void;

        function resetAll(): void;

        function initConfigurationDownload(): void;

        function get events(): IEventDispatcher;
    }
}
