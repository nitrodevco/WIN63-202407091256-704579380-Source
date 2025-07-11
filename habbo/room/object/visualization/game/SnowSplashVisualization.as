package com.sulake.habbo.room.object.visualization.game {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.habbo.room.object.visualization.furniture.class_3480
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization
    import com.sulake.room.utils.IRoomGeometry

    import flash.display.BitmapData

    public class SnowSplashVisualization extends RoomObjectSpriteVisualization {

        private static const FRAME_ASSET_NAMES: Array = ["snowball_splash_1", "snowball_splash_2", "snowball_splash_3"];

        public function SnowSplashVisualization() {
            super();
        }
        private var _frameNumber: int = 0;
        private var var_47: class_3480;

        public function get isDone(): Boolean {
            return _frameNumber >= FRAME_ASSET_NAMES.length;
        }

        override public function initialize(param1: IRoomObjectVisualizationData): Boolean {
            var _loc2_: BitmapDataAsset = null;
            var_47 = param1 as class_3480;
            createSprites(1);
            _loc2_ = var_47.assets.getAssetByName(FRAME_ASSET_NAMES[_frameNumber]) as BitmapDataAsset;
            getSprite(0).asset = _loc2_.content as BitmapData;
            return true;
        }

        override public function update(param1: IRoomGeometry, param2: int, param3: Boolean, param4: Boolean): void {
            _frameNumber++;
            getSprite(0).asset = isDone ? null : var_47.assets.getAssetByName(FRAME_ASSET_NAMES[_frameNumber]).content as BitmapData;
        }
    }
}
