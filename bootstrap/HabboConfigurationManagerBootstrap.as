package com.sulake.bootstrap {
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.runtime.IContext
    import com.sulake.habbo.configuration.HabboConfigurationManager

    public class HabboConfigurationManagerBootstrap extends HabboConfigurationManager {

        public function HabboConfigurationManagerBootstrap(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null) {
            super(param1, param2, param3);
        }
    }
}
