package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData

    public class class_3480 implements IRoomObjectVisualizationData {

        public function class_3480() {
            super();
        }

        private var _assets: IAssetLibrary;

        public function get assets(): IAssetLibrary {
            return _assets;
        }

        public function set assets(param1: IAssetLibrary): void {
            _assets = param1;
        }

        public function dispose(): void {
            _assets = null;
        }

        public function initialize(param1: XML): Boolean {
            return true;
        }
    }
}
