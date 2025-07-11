package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.habbo.utils.StringBuffer
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.visualization.IRoomObjectSprite
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization
    import com.sulake.room.object.visualization.utils.IGraphicAsset
    import com.sulake.room.utils.IRoomGeometry

    import flash.display.BitmapData

    public class FurnitureVisualization extends RoomObjectSpriteVisualization {

        protected static const Z_MULTIPLIER: Number = Math.sqrt(0.5);
        private const const_503: int = 41;
        private static var var_2649: StringBuffer;
        private static var var_1999: Array;

        public function FurnitureVisualization() {
            var_713 = [];
            _assetNamesFrame = [];
            var_2323 = [];
            var_2194 = [];
            _spriteColors = [];
            var_2391 = [];
            var_2380 = [];
            var_2325 = [];
            var_2368 = [];
            var_2356 = [];
            super();
            reset();
            if (!var_2649) {
                var_2649 = new StringBuffer();
                var_1999 = [];
                var_1999[0] = null;
                var_1999[1] = "_";
                var_1999[2] = null;
                var_1999[3] = "_";
                var_1999[4] = null;
                var_1999[5] = "_";
                var_1999[6] = null;
                var_1999[7] = "_";
            }
        }
        protected var var_2792: Number = 1;
        protected var var_2799: Boolean = true;
        protected var var_2448: int = 0;
        protected var var_3910: int = -1;
        private var _lastUpdateTime: int = -1000;
        private var var_1210: int;
        private var var_4363: Number = NaN;
        private var _selectedColor: int = -1;
        private var var_3950: String = null;
        private var var_4111: Boolean = false;
        private var var_47: FurnitureVisualizationData = null;
        private var var_329: String = "";
        private var var_713: Array;
        private var _assetNamesFrame: Array;
        private var var_4348: Number = 0;
        private var var_4116: int = -1;
        private var var_4392: int = -1;
        private var var_2323: Array;
        private var var_2194: Array;
        private var _spriteColors: Array;
        private var var_2391: Array;
        private var var_2380: Array;
        private var var_2325: Array;
        private var var_2368: Array;
        private var var_2356: Array;
        private var _updatedLayers: int = 0;
        private var var_4634: Number = 0;
        private var var_4259: Boolean = false;
        private var var_3680: Boolean = false;
        private var var_3949: Boolean = false;

        private var _filters: Array = null;

        public function get filters(): Array {
            return _filters;
        }

        public function set filters(param1: Array): * {
            _filters = param1;
            var_3949 = true;
        }

        public function set lookThrough(param1: Boolean): * {
            if (var_4259 != param1) {
                var_3680 = true;
                var_4259 = param1;
            }
        }

        protected function get direction(): int {
            return var_1210;
        }

        protected function set direction(param1: int): void {
            var_1210 = param1;
        }

        protected function get type(): String {
            return var_329;
        }

        protected function get data(): FurnitureVisualizationData {
            return var_47;
        }

        override public function dispose(): void {
            super.dispose();
            var_47 = null;
            var_713 = null;
            _assetNamesFrame = null;
            var_2323 = null;
            var_2194 = null;
            _spriteColors = null;
            var_2391 = null;
            var_2380 = null;
            var_2325 = null;
            var_2368 = null;
            var_2356 = null;
            _filters = null;
        }

        override protected function reset(): void {
            super.reset();
            direction = -1;
            var_47 = null;
            var_713 = [];
            _assetNamesFrame = [];
            var_2323 = [];
            var_2194 = [];
            _spriteColors = [];
            var_2391 = [];
            var_2380 = [];
            var_2325 = [];
            var_2368 = [];
            var_2356 = [];
            this.createSprites(0);
        }

        override public function initialize(param1: IRoomObjectVisualizationData): Boolean {
            reset();
            if (param1 == null || !(param1 is FurnitureVisualizationData)) {
                return false;
            }
            var_47 = param1 as FurnitureVisualizationData;
            var_329 = var_47.getType();
            return true;
        }

        override public function update(param1: IRoomGeometry, param2: int, param3: Boolean, param4: Boolean): void {
            if (param1 == null) {
                return;
            }
            if (param2 < _lastUpdateTime + 41) {
                return;
            }
            _lastUpdateTime += 41;
            if (_lastUpdateTime + 41 < param2) {
                _lastUpdateTime = param2 - 41;
            }
            var _loc5_: Boolean = false;
            var _loc6_: Number = param1.scale;
            if (updateObject(_loc6_, param1.direction.x)) {
                _loc5_ = true;
            }
            if (updateModel(_loc6_)) {
                _loc5_ = true;
            }
            if (var_3680) {
                _loc5_ = true;
                var_3680 = false;
            }
            if (var_3949) {
                _loc5_ = true;
                var_3949 = false;
            }
            var _loc7_: * = 0;
            if (param4) {
                _updatedLayers |= updateAnimation(_loc6_);
            } else {
                _loc7_ = updateAnimation(_loc6_) | _updatedLayers;
                _updatedLayers = 0;
            }
            if (_loc5_ || _loc7_ != 0) {
                updateSprites(_loc6_, _loc5_, _loc7_);
                var_1755 = _loc6_;
                increaseUpdateId();
            }
        }

        protected function updateSprites(param1: int, param2: Boolean, param3: int): void {
            var _loc5_: int = 0;
            var _loc4_: int = 0;
            if (var_2448 != spriteCount) {
                createSprites(var_2448);
            }
            if (param2) {
                _loc5_ = spriteCount - 1;
                while (_loc5_ >= 0) {
                    updateSprite(param1, _loc5_);
                    _loc5_--;
                }
            } else {
                _loc4_ = 0;
                while (param3 > 0) {
                    if (param3 & 1) {
                        updateSprite(param1, _loc4_);
                    }
                    _loc4_++;
                    param3 >>= 1;
                }
            }
            var_2799 = false;
        }

        protected function updateSprite(param1: int, param2: int): void {
            var _loc7_: IGraphicAsset = null;
            var _loc3_: Number = NaN;
            var _loc4_: int = 0;
            var _loc5_: String = getSpriteAssetName(param1, param2);
            var _loc6_: IRoomObjectSprite;
            if ((_loc6_ = getSprite(param2)) != null && _loc5_ != null) {
                if ((_loc7_ = getAsset(_loc5_, param2)) != null && _loc7_.asset != null) {
                    _loc6_.visible = true;
                    _loc6_.objectType = var_329;
                    _loc6_.asset = _loc7_.asset.content as BitmapData;
                    if (_loc7_.asset.content == null) {
                        var_1804++;
                    }
                    _loc6_.flipH = _loc7_.flipH;
                    _loc6_.flipV = _loc7_.flipV;
                    _loc6_.direction = var_1210;
                    _loc3_ = 0;
                    if (param2 != var_3910) {
                        _loc6_.tag = getSpriteTag(param1, var_1210, param2);
                        _loc6_.alpha = getSpriteAlpha(param1, var_1210, param2);
                        _loc6_.color = getSpriteColor(param1, param2, _selectedColor);
                        _loc6_.offsetX = _loc7_.offsetX + getSpriteXOffset(param1, var_1210, param2);
                        _loc6_.offsetY = _loc7_.offsetY + getSpriteYOffset(param1, var_1210, param2);
                        _loc6_.alphaTolerance = getSpriteMouseCapture(param1, var_1210, param2) ? 128 : 256;
                        _loc6_.blendMode = getBlendMode(getSpriteInk(param1, var_1210, param2));
                        _loc3_ = getSpriteZOffset(param1, var_1210, param2);
                        _loc3_ -= param2 * 0.001;
                    } else {
                        _loc6_.offsetX = _loc7_.offsetX;
                        _loc6_.offsetY = _loc7_.offsetY + getSpriteYOffset(param1, var_1210, param2);
                        _loc4_ = (_loc4_ = 48) * var_2792;
                        _loc6_.alpha = _loc4_;
                        _loc6_.alphaTolerance = 256;
                        _loc3_ = 1;
                    }
                    if (var_4259) {
                        _loc6_.alpha *= 0.2;
                    }
                    _loc3_ *= Z_MULTIPLIER;
                    _loc6_.relativeDepth = _loc3_;
                    _loc6_.assetName = _loc7_.assetName;
                    _loc6_.libraryAssetName = getLibraryAssetNameForSprite(_loc7_, _loc6_);
                    _loc6_.assetPosture = getPostureForAssetFile(param1, _loc7_.libraryAssetName);
                    _loc6_.clickHandling = var_4111;
                    if (_loc6_.blendMode != "add") {
                        _loc6_.filters = _filters;
                    }
                } else {
                    resetSprite(_loc6_, param2);
                }
            } else if (_loc6_ != null) {
                resetSprite(_loc6_, param2);
            }
        }

        protected function getLibraryAssetNameForSprite(param1: IGraphicAsset, param2: IRoomObjectSprite): String {
            return param1.libraryAssetName;
        }

        protected function getBlendMode(param1: int): String {
            var _loc2_: String = "normal";
            switch (param1) {
                case 0:
                    break;
                case 1:
                    _loc2_ = "add";
                    break;
                case 2:
                    _loc2_ = "subtract";
                    break;
                case 3:
                    _loc2_ = "darken";
                    break;
                case 4:
                    _loc2_ = "difference";
                    break;
                case 5:
                    _loc2_ = "multiply";
                    break;
                case 6:
                    _loc2_ = "invert";
                    break;
                case 7:
                    _loc2_ = "screen";
            }
            return _loc2_;
        }

        protected function updateObject(param1: Number, param2: Number): Boolean {
            var _loc4_: Number = NaN;
            var _loc5_: int = 0;
            var _loc3_: IRoomObject = object;
            if (_loc3_ == null) {
                return false;
            }
            if (var_2880 != _loc3_.getUpdateID() || param1 != var_1755 || param2 != var_4363) {
                _loc4_ = ((_loc4_ = _loc3_.getDirection().x - (param2 + 135)) % 360 + 360) % 360;
                if (var_47 != null) {
                    direction = _loc5_ = var_47.getDirectionValue(param1, _loc4_);
                }
                var_2880 = _loc3_.getUpdateID();
                var_4363 = param2;
                var_1755 = param1;
                updateAssetAndSpriteCache(param1, var_1210);
                return true;
            }
            return false;
        }

        protected function updateModel(param1: Number): Boolean {
            var _loc4_: Number = NaN;
            var _loc2_: IRoomObject = object;
            if (_loc2_ == null) {
                return false;
            }
            var _loc3_: IRoomObjectModel = _loc2_.getModel();
            if (_loc3_ == null) {
                return false;
            }
            if (var_1804 != _loc3_.getUpdateID()) {
                _selectedColor = _loc3_.getNumber("furniture_color");
                _loc4_ = Number(_loc3_.getNumber("furniture_alpha_multiplier"));
                if (isNaN(_loc4_)) {
                    _loc4_ = 1;
                }
                if (_loc4_ != var_2792) {
                    var_2792 = _loc4_;
                    var_2799 = true;
                }
                var_3950 = getAdClickUrl(_loc3_);
                var_4111 = var_3950 != null && var_3950 != "" && var_3950.indexOf("http") == 0;
                var_4634 = _loc3_.getNumber("furniture_lift_amount");
                var_1804 = _loc3_.getUpdateID();
                return true;
            }
            return false;
        }

        protected function getAdClickUrl(param1: IRoomObjectModel): String {
            return param1.getString("furniture_ad_url");
        }

        protected function updateAnimation(param1: Number): int {
            return 0;
        }

        protected function updateLayerCount(param1: int): void {
            var_2448 = param1;
            var_3910 = var_2448 - getAdditionalSpriteCount();
        }

        protected function getAdditionalSpriteCount(): int {
            return 1;
        }

        protected function getFrameNumber(param1: int, param2: int): int {
            return 0;
        }

        protected function getPostureForAssetFile(param1: int, param2: String): String {
            return null;
        }

        protected function getAsset(param1: String, param2: int = -1): IGraphicAsset {
            var _loc3_: * = null;
            if (assetCollection != null) {
                return assetCollection.getAsset(param1);
            }
            return null;
        }

        protected function getSpriteAssetName(param1: int, param2: int): String {
            if (var_47 == null || param2 >= FurnitureVisualizationData.LAYER_NAMES.length) {
                return "";
            }
            var _loc4_: String = String(var_713[param2]);
            var _loc3_: * = Boolean(_assetNamesFrame[param2]);
            if (_loc4_ == null || _loc4_.length == 0) {
                _loc4_ = getSpriteAssetNameWithoutFrame(param1, param2, true);
                _loc3_ = var_4116 != 1;
            }
            if (_loc3_) {
                _loc4_ += getFrameNumber(param1, param2);
            }
            return _loc4_;
        }

        protected function getSpriteAssetNameWithoutFrame(param1: int, param2: int, param3: Boolean): String {
            var _loc7_: String = null;
            var _loc4_: int;
            var _loc5_: * = (_loc4_ = param3 ? var_4116 : getSize(param1)) == 1;
            if (param2 != var_3910) {
                _loc7_ = String(FurnitureVisualizationData.LAYER_NAMES[param2]);
            } else {
                _loc7_ = "sd";
            }
            if (_loc5_) {
                return var_329 + "_icon_" + _loc7_;
            }
            var_1999[0] = var_329;
            var_1999[2] = _loc4_;
            var_1999[4] = _loc7_;
            var_1999[6] = var_1210;
            var_2649.length = 0;
            var_2649.appendStringArray(var_1999);
            var _loc6_: String = var_2649.toString();
            if (param3) {
                var_713[param2] = _loc6_;
                _assetNamesFrame[param2] = !_loc5_;
            }
            return _loc6_;
        }

        protected function getSpriteTag(param1: int, param2: int, param3: int): String {
            if (var_2323[param3] != null) {
                return var_2323[param3];
            }
            if (var_47 == null) {
                return "";
            }
            var _loc4_: String = var_47.getTag(param1, param2, param3);
            var_2323[param3] = _loc4_;
            return _loc4_;
        }

        protected function getSpriteAlpha(param1: int, param2: int, param3: int): int {
            if (var_2194[param3] != null && !var_2799) {
                return var_2194[param3];
            }
            if (var_47 == null) {
                return 255;
            }
            var _loc4_: int = (_loc4_ = var_47.getAlpha(param1, param2, param3)) * var_2792;
            var_2194[param3] = _loc4_;
            return _loc4_;
        }

        protected function getSpriteColor(param1: int, param2: int, param3: int): int {
            if (_spriteColors[param2] != null) {
                return _spriteColors[param2];
            }
            if (var_47 == null) {
                return 16777215;
            }
            var _loc4_: int = var_47.getColor(param1, param2, param3);
            _spriteColors[param2] = _loc4_;
            return _loc4_;
        }

        protected function getSpriteXOffset(param1: int, param2: int, param3: int): int {
            if (var_2391[param3] != null) {
                return var_2391[param3];
            }
            if (var_47 == null) {
                return 0;
            }
            var _loc4_: int = var_47.getXOffset(param1, param2, param3);
            var_2391[param3] = _loc4_;
            return _loc4_;
        }

        protected function getSpriteYOffset(param1: int, param2: int, param3: int): int {
            var _loc4_: int = 0;
            if (param3 != var_3910) {
                if (var_2380[param3] != null) {
                    return var_2380[param3];
                }
                if (var_47 != null) {
                    _loc4_ = var_47.getYOffset(param1, param2, param3);
                    var_2380[param3] = _loc4_;
                    return _loc4_;
                }
                return 0;
            }
            return Math.ceil(var_4634 * (param1 / 2));
        }

        protected function getSpriteMouseCapture(param1: int, param2: int, param3: int): Boolean {
            if (var_2368[param3] != null) {
                return var_2368[param3];
            }
            if (var_47 == null) {
                return true;
            }
            var _loc4_: * = !var_47.getIgnoreMouse(param1, param2, param3);
            var_2368[param3] = _loc4_;
            return _loc4_;
        }

        protected function getSpriteInk(param1: int, param2: int, param3: int): int {
            if (var_2356[param3] != null) {
                return var_2356[param3];
            }
            if (var_47 == null) {
                return 0;
            }
            var _loc4_: int = var_47.getInk(param1, param2, param3);
            var_2356[param3] = _loc4_;
            return _loc4_;
        }

        protected function getSpriteZOffset(param1: int, param2: int, param3: int): Number {
            if (var_2325[param3] != null) {
                return var_2325[param3];
            }
            if (var_47 == null) {
                return 0;
            }
            var _loc4_: Number = var_47.getZOffset(param1, param2, param3);
            var_2325[param3] = _loc4_;
            return _loc4_;
        }

        protected function getSize(param1: int): int {
            if (var_47 != null) {
                return var_47.getSize(param1);
            }
            return param1;
        }

        private function resetSprite(param1: IRoomObjectSprite, param2: int): void {
            param1.asset = null;
            param1.assetName = "";
            param1.assetPosture = null;
            param1.alpha = 0;
            param1.tag = "";
            param1.flipH = false;
            param1.flipV = false;
            param1.offsetX = 0;
            param1.offsetY = 0;
            param1.relativeDepth = 0;
            param1.clickHandling = false;
            if (var_2799) {
                delete var_2194[param2];
            }
        }

        private function updateAssetAndSpriteCache(param1: Number, param2: int): void {
            if (var_4392 != param2 || var_4348 != param1) {
                var_713 = [];
                _assetNamesFrame = [];
                var_2323 = [];
                var_2194 = [];
                _spriteColors = [];
                var_2391 = [];
                var_2380 = [];
                var_2325 = [];
                var_2368 = [];
                var_2356 = [];
                var_4392 = param2;
                var_4348 = param1;
                var_4116 = getSize(param1);
                updateLayerCount(var_47.getLayerCount(param1) + getAdditionalSpriteCount());
            }
        }
    }
}
