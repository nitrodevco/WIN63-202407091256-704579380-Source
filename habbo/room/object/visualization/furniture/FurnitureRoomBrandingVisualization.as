package com.sulake.habbo.room.object.visualization.furniture {
    import assets.class_14

    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.object.visualization.utils.IGraphicAsset

    import flash.display.BitmapData
    import flash.geom.Matrix

    public class FurnitureRoomBrandingVisualization extends FurnitureVisualization {

        private static const BRANDED_IMAGE_SPRITE_TAG: String = "branded_image";

        private static const OBJECT_STATE_DEFAULT: int = 0;

        private static const OBJECT_STATE_FLIPH: int = 1;

        private static const const_606: int = 2;

        private static const const_1005: int = 3;

        public function FurnitureRoomBrandingVisualization() {
            super();
        }
        protected var var_406: String;
        protected var var_3244: Boolean = false;
        protected var var_3926: int;
        protected var var_3675: int;
        protected var var_4183: int;
        private var _dynamicAssetName: String;

        override public function dispose(): void {
            if (_dynamicAssetName && assetCollection) {
                assetCollection.disposeAsset(_dynamicAssetName);
                _dynamicAssetName = null;
            }
            super.dispose();
            var_406 = null;
        }

        override protected function updateObject(param1: Number, param2: Number): Boolean {
            if (super.updateObject(param1, param2)) {
                if (var_3244) {
                    checkAndCreateImageForCurrentState(param1);
                }
                return true;
            }
            return false;
        }

        override protected function updateModel(param1: Number): Boolean {
            var _loc2_: IRoomObject = null;
            var _loc3_: IRoomObjectModel = null;
            var _loc4_: Boolean;
            if (_loc4_ = super.updateModel(param1)) {
                _loc2_ = object;
                if (_loc2_ != null) {
                    _loc3_ = _loc2_.getModel();
                    if (_loc3_ != null) {
                        var_3926 = _loc3_.getNumber("furniture_branding_offset_x");
                        var_3675 = _loc3_.getNumber("furniture_branding_offset_y");
                        var_4183 = _loc3_.getNumber("furniture_branding_offset_z");
                    }
                }
            }
            if (!var_3244) {
                var_3244 = checkIfImageReady();
                if (var_3244) {
                    checkAndCreateImageForCurrentState(param1);
                    return true;
                }
            } else if (checkIfImageChanged()) {
                var_3244 = false;
                var_406 = null;
                return true;
            }
            return _loc4_;
        }

        override protected function updateSprites(param1: int, param2: Boolean, param3: int): void {
            super.updateSprites(param1, param2, param3);
        }

        override protected function getSpriteAssetName(param1: int, param2: int): String {
            var _loc7_: int = 0;
            var _loc4_: int = getSize(param1);
            var _loc5_: String = type;
            var _loc6_: String = "";
            if (param2 < spriteCount - 1) {
                _loc6_ = String.fromCharCode("a".charCodeAt() + param2);
            } else {
                _loc6_ = "sd";
            }
            if (_loc4_ == 1) {
                _loc5_ += "_icon_" + _loc6_;
            } else {
                _loc7_ = getFrameNumber(param1, param2);
                _loc5_ += "_" + _loc4_ + "_" + _loc6_ + "_" + direction + "_" + _loc7_;
            }
            var _loc3_: String = getSpriteTag(param1, direction, param2);
            if (var_406 != null && _loc3_ == "branded_image") {
                return var_406 + "_" + _loc4_ + "_" + object.getState(0);
            }
            return _loc5_;
        }

        override protected function getLibraryAssetNameForSprite(param1: IGraphicAsset, param2: IRoomObjectSprite): String {
            var _loc3_: String = null;
            if (param2.tag != "branded_image") {
                return super.getLibraryAssetNameForSprite(param1, param2);
            }
            if (object) {
                _loc3_ = String(object.getModel().getString("furniture_branding_image_url"));
            }
            if (_loc3_ && _loc3_.length > 0) {
                return _loc3_;
            }
            return super.getLibraryAssetNameForSprite(param1, param2);
        }

        protected function checkIfImageChanged(): Boolean {
            var _loc3_: IRoomObjectModel = null;
            var _loc2_: String = null;
            var _loc1_: IRoomObject = object;
            if (_loc1_ != null) {
                _loc3_ = _loc1_.getModel();
                if (_loc3_ != null) {
                    _loc2_ = String(_loc3_.getString("furniture_branding_image_url"));
                    if (_loc2_ != null && _loc2_ != var_406) {
                        return true;
                    }
                }
            }
            return false;
        }

        protected function checkIfImageReady(): Boolean {
            var _loc4_: IRoomObjectModel = null;
            var _loc3_: String = null;
            var _loc5_: Number = NaN;
            var _loc6_: IGraphicAsset = null;
            var _loc2_: BitmapData = null;
            var _loc1_: IRoomObject = object;
            if (_loc1_ != null) {
                if ((_loc4_ = _loc1_.getModel()) != null) {
                    _loc3_ = String(_loc4_.getString("furniture_branding_image_url"));
                    if (_loc3_ != null) {
                        if (var_406 == null || var_406 != _loc3_) {
                            if ((_loc5_ = Number(_loc4_.getNumber("furniture_branding_image_status"))) == 1) {
                                if ((_loc6_ = assetCollection.getAsset(_loc3_)) != null) {
                                    _loc2_ = _loc6_.asset.content as BitmapData;
                                    if (_loc2_ != null) {
                                        imageReady(_loc2_, _loc3_);
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return false;
        }

        protected function imageReady(param1: BitmapData, param2: String): void {
            class_14.log("billboard visualization got image from url = " + param2);
            if (param1 != null) {
                var_406 = param2;
            } else {
                var_406 = null;
            }
        }

        private function checkAndCreateImageForCurrentState(param1: int): void {
            var _loc2_: BitmapData = null;
            var _loc6_: Matrix = null;
            if (object == null || var_406 == null) {
                return;
            }
            var _loc11_: IGraphicAsset;
            if ((_loc11_ = assetCollection.getAsset(var_406)) == null) {
                return;
            }
            var _loc14_: int = object.getState(0);
            var _loc9_: int = getSize(param1);
            var _loc12_: String = var_406 + "_" + _loc9_ + "_" + _loc14_;
            var _loc15_: IGraphicAsset;
            if ((_loc15_ = assetCollection.getAsset(_loc12_)) != null) {
                return;
            }
            var _loc10_: BitmapData;
            if ((_loc10_ = _loc11_.asset.content as BitmapData) == null) {
                class_14.log("could not find bitmap data for image " + _loc12_);
                return;
            }
            var _loc4_: Boolean = true;
            if (var_406.indexOf("noscale") > -1) {
                _loc4_ = false;
            }
            if (var_406.indexOf("force32") > -1) {
                _loc9_ = 32;
            }
            if (_loc9_ == 32 && _loc4_) {
                (_loc6_ = new Matrix()).scale(0.5, 0.5);
                _loc2_ = new BitmapData(_loc10_.width / 2, _loc10_.height / 2, true, 16777215);
                _loc2_.draw(_loc10_, _loc6_);
            } else {
                _loc2_ = _loc10_.clone();
            }
            var _loc7_: int = 0;
            var _loc8_: int = 0;
            var _loc5_: Boolean = false;
            var _loc13_: Boolean = false;
            switch (_loc14_) {
                case 0:
                    _loc7_ = 0;
                    _loc8_ = 0;
                    _loc5_ = false;
                    _loc13_ = false;
                    break;
                case 1:
                    _loc7_ = -_loc2_.width;
                    _loc8_ = 0;
                    _loc5_ = true;
                    _loc13_ = false;
                    break;
                case 2:
                    _loc7_ = -_loc2_.width;
                    _loc8_ = -_loc2_.height;
                    _loc5_ = true;
                    _loc13_ = true;
                    break;
                case 3:
                    _loc7_ = 0;
                    _loc8_ = -_loc2_.height;
                    _loc5_ = false;
                    _loc13_ = true;
                    break;
                default:
                    class_14.log("could not handle unknown state " + _loc14_);
            }
            if (_dynamicAssetName) {
                assetCollection.disposeAsset(_dynamicAssetName);
            }
            _dynamicAssetName = _loc12_;
            var _loc3_: Boolean = assetCollection.addAsset(_loc12_, _loc2_, true, _loc7_, _loc8_, _loc5_, _loc13_);
            if (!_loc3_) {
                class_14.log("could not add asset for image " + _loc12_);
            }
        }
    }
}
