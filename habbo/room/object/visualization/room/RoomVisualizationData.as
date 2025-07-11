package com.sulake.habbo.room.object.visualization.room {
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer
    import com.sulake.habbo.room.object.visualization.room.rasterizer.class_3625
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData
    import com.sulake.room.object.visualization.utils.class_3367

    public class RoomVisualizationData implements IRoomObjectVisualizationData {

        public function RoomVisualizationData() {
            super();
            var_2305 = new WallRasterizer();
            var_2353 = new FloorRasterizer();
            var_2705 = new WallAdRasterizer();
            var_2383 = new LandscapeRasterizer();
            var_2665 = new PlaneMaskManager();
        }
        private var var_2305: WallRasterizer;
        private var var_2353: FloorRasterizer;
        private var var_2705: WallAdRasterizer;
        private var var_2383: LandscapeRasterizer;
        private var var_2665: PlaneMaskManager;
        private var var_78: Boolean = false;

        public function get initialized(): Boolean {
            return var_78;
        }

        public function get floorRasterizer(): class_3625 {
            return var_2353;
        }

        public function get wallRasterizer(): class_3625 {
            return var_2305;
        }

        public function get wallAdRasterizr(): WallAdRasterizer {
            return var_2705;
        }

        public function get landscapeRasterizer(): class_3625 {
            return var_2383;
        }

        public function get maskManager(): PlaneMaskManager {
            return var_2665;
        }

        public function dispose(): void {
            if (var_2305 != null) {
                var_2305.dispose();
                var_2305 = null;
            }
            if (var_2353 != null) {
                var_2353.dispose();
                var_2353 = null;
            }
            if (var_2705 != null) {
                var_2705.dispose();
                var_2705 = null;
            }
            if (var_2383 != null) {
                var_2383.dispose();
                var_2383 = null;
            }
            if (var_2665 != null) {
                var_2665.dispose();
                var_2665 = null;
            }
        }

        public function clearCache(): void {
            if (var_2305 != null) {
                var_2305.clearCache();
            }
            if (var_2353 != null) {
                var_2353.clearCache();
            }
            if (var_2383 != null) {
                var_2383.clearCache();
            }
        }

        public function initialize(param1: XML): Boolean {
            var _loc4_: XML = null;
            var _loc3_: XML = null;
            var _loc7_: XML = null;
            var _loc11_: XML = null;
            var _loc6_: XML = null;
            reset();
            if (param1 == null) {
                return false;
            }
            var _loc5_: XMLList;
            if ((_loc5_ = param1.wallData).length() > 0) {
                _loc4_ = _loc5_[0];
                var_2305.initialize(_loc4_);
            }
            var _loc2_: XMLList = param1.floorData;
            if (_loc2_.length() > 0) {
                _loc3_ = _loc2_[0];
                var_2353.initialize(_loc3_);
            }
            var _loc10_: XMLList;
            if ((_loc10_ = param1.wallAdData).length() > 0) {
                _loc7_ = _loc10_[0];
                var_2705.initialize(_loc7_);
            }
            var _loc8_: XMLList;
            if ((_loc8_ = param1.landscapeData).length() > 0) {
                _loc11_ = _loc8_[0];
                var_2383.initialize(_loc11_);
            }
            var _loc9_: XMLList;
            if ((_loc9_ = param1.maskData).length() > 0) {
                _loc6_ = _loc9_[0];
                var_2665.initialize(_loc6_);
            }
            return true;
        }

        public function initializeAssetCollection(param1: class_3367): void {
            if (var_78) {
                return;
            }
            var_2305.initializeAssetCollection(param1);
            var_2353.initializeAssetCollection(param1);
            var_2705.initializeAssetCollection(param1);
            var_2383.initializeAssetCollection(param1);
            var_2665.initializeAssetCollection(param1);
            var_78 = true;
        }

        protected function reset(): void {
        }
    }
}
