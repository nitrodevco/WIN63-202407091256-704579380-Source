package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.visualization.utils.IGraphicAsset

    import flash.display.Bitmap
    import flash.display.BitmapData
    import flash.geom.ColorTransform
    import flash.geom.Matrix

    public class class_3389 extends AnimatedFurnitureVisualization {

        protected static const THUMBNAIL_SPRITE_TAG: String = "THUMBNAIL";

        public function class_3389() {
            super();
        }
        private var var_4257: String = null;
        private var _thumbnailAssetNameNormal: String = null;
        private var var_4780: Boolean = false;
        private var var_4581: BitmapData;
        private var _thumbnailImageNormal: BitmapData;
        private var var_4399: int;
        private var var_3946: Boolean;

        public function set hasOutline(param1: Boolean): void {
            var_4780 = param1;
        }

        public function get hasThumbnailImage(): Boolean {
            return _thumbnailImageNormal != null;
        }

        override protected function updateModel(param1: Number): Boolean {
            var _loc2_: Boolean = super.updateModel(param1);
            if (!object) {
                return _loc2_;
            }
            if (!var_3946 && var_4399 == direction) {
                return _loc2_;
            }
            refreshThumbnail();
            return true;
        }

        override protected function getSpriteAssetName(param1: int, param2: int): String {
            if (_thumbnailImageNormal == null || getSpriteTag(param1, direction, param2) != "THUMBNAIL") {
                return super.getSpriteAssetName(param1, param2);
            }
            return getThumbnailAssetName(param1);
        }

        public function setThumbnailImages(param1: BitmapData, param2: BitmapData = null): void {
            _thumbnailImageNormal = param1;
            var_4581 = param2 != null ? param2 : param1;
            var_3946 = true;
        }

        protected function getThumbnailAssetName(param1: int): String {
            if (var_4257 == null) {
                var_4257 = getFullThumbnailAssetName(object.getId(), 32);
                _thumbnailAssetNameNormal = getFullThumbnailAssetName(object.getId(), 64);
            }
            return param1 == 32 ? var_4257 : _thumbnailAssetNameNormal;
        }

        protected function getFullThumbnailAssetName(param1: int, param2: int): String {
            return [type, param1, "thumb", param2].join("_");
        }

        private function refreshThumbnail(): void {
            if (assetCollection == null) {
                return;
            }
            if (_thumbnailImageNormal != null) {
                addThumbnailAsset(_thumbnailImageNormal, 64);
                addThumbnailAsset(var_4581, 32);
            } else {
                assetCollection.disposeAsset(getThumbnailAssetName(64));
                assetCollection.disposeAsset(getThumbnailAssetName(32));
            }
            var_3946 = false;
            var_4399 = direction;
        }

        private function addThumbnailAsset(param1: BitmapData, param2: int): void {
            var _loc5_: int = 0;
            var _loc6_: String = null;
            var _loc4_: IGraphicAsset = null;
            var _loc3_: BitmapData = null;
            var _loc7_: String = null;
            _loc5_ = 0;
            while (_loc5_ < spriteCount) {
                if (getSpriteTag(param2, direction, _loc5_) == "THUMBNAIL") {
                    _loc6_ = getSpriteAssetNameWithoutFrame(param2, _loc5_, false) + getFrameNumber(param2, _loc5_);
                    if ((_loc4_ = getAsset(_loc6_, _loc5_)) != null) {
                        _loc3_ = generateTransformedThumbnail(param1, _loc4_);
                        _loc7_ = getThumbnailAssetName(param2);
                        assetCollection.disposeAsset(_loc7_);
                        assetCollection.addAsset(_loc7_, _loc3_, true, _loc4_.offsetX, _loc4_.offsetY);
                    }
                    return;
                }
                _loc5_++;
            }
        }

        private function generateTransformedThumbnail(param1: BitmapData, param2: IGraphicAsset): BitmapData {
            var _loc3_: BitmapData = null;
            var _loc8_: Bitmap = null;
            var _loc7_: ColorTransform = null;
            var _loc4_: Number = 1.1;
            var _loc6_: Matrix = new Matrix();
            var _loc5_: Number = param2.width / param1.width;
            switch (direction) {
                case 0:
                case 4:
                    _loc6_.a = _loc5_;
                    _loc6_.b = 0.5 * _loc5_;
                    _loc6_.c = 0;
                    _loc6_.d = _loc5_ * _loc4_;
                    _loc6_.tx = 0;
                    _loc6_.ty = 0;
                    break;
                case 2:
                    _loc6_.a = _loc5_;
                    _loc6_.b = -0.5 * _loc5_;
                    _loc6_.c = 0;
                    _loc6_.d = _loc5_ * _loc4_;
                    _loc6_.tx = 0;
                    _loc6_.ty = 0.5 * _loc5_ * param1.width;
                    break;
                default:
                    _loc6_.a = _loc5_;
                    _loc6_.b = 0;
                    _loc6_.c = 0;
                    _loc6_.d = _loc5_;
                    _loc6_.tx = 0;
                    _loc6_.ty = 0;
            }
            if (var_4780) {
                _loc3_ = new BitmapData(param2.width + 2, param2.height + 2, true, 0);
                _loc8_ = new Bitmap(param1);
                (_loc7_ = new ColorTransform()).color = 0;
                _loc3_.draw(_loc8_, _loc6_, _loc7_);
                _loc6_.tx += 1;
                _loc6_.ty -= 1;
                _loc3_.draw(_loc8_, _loc6_, _loc7_);
                _loc6_.ty += 2;
                _loc3_.draw(_loc8_, _loc6_, _loc7_);
                _loc6_.tx += 1;
                _loc6_.ty -= 1;
                _loc3_.draw(_loc8_, _loc6_, _loc7_);
                _loc6_.tx -= 1;
                _loc3_.draw(_loc8_, _loc6_);
            } else {
                _loc3_ = new BitmapData(param2.width, param2.height, true, 0);
                _loc3_.draw(param1, _loc6_);
            }
            return _loc3_;
        }
    }
}
