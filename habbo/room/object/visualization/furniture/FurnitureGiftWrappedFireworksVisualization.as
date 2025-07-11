package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.utils.IRoomGeometry

    public class FurnitureGiftWrappedFireworksVisualization extends FurnitureFireworksVisualization {

        private static const PRESENT_DEFAULT_STATE: int = 0;

        private static const MAX_PACKET_TYPE_VALUE: int = 9;

        private static const MAX_RIBBON_TYPE_VALUE: int = 11;

        public function FurnitureGiftWrappedFireworksVisualization() {
            super();
        }
        private var var_4511: int = 0;
        private var var_4509: int = 0;
        private var var_149: int = 0;

        override public function update(param1: IRoomGeometry, param2: int, param3: Boolean, param4: Boolean): void {
            updateTypes();
            super.update(param1, param2, param3, param4);
        }

        override protected function getFrameNumber(param1: int, param2: int): int {
            if (var_149 == 0) {
                if (param2 <= 1) {
                    return var_4511;
                }
                if (param2 == 2) {
                    return var_4509;
                }
            }
            return super.getFrameNumber(param1, param2);
        }

        override protected function getSpriteAssetName(param1: int, param2: int): String {
            var _loc3_: int = getSize(param1);
            var _loc4_: String = type;
            var _loc5_: String = "";
            if (param2 < spriteCount - 1) {
                _loc5_ = String.fromCharCode("a".charCodeAt() + param2);
            } else {
                _loc5_ = "sd";
            }
            var _loc6_: int = getFrameNumber(param1, param2);
            return (_loc4_ += "_" + _loc3_ + "_" + _loc5_ + "_" + direction) + ("_" + _loc6_);
        }

        override protected function setAnimation(param1: int): void {
            var_149 = param1;
            super.setAnimation(param1);
        }

        private function updateTypes(): void {
            var _loc6_: IRoomObjectModel = null;
            var _loc1_: int = 0;
            var _loc4_: String = null;
            var _loc5_: int = 0;
            var _loc2_: int = 0;
            var _loc7_: int = 0;
            var _loc3_: IRoomObject = object;
            if (_loc3_ != null) {
                if ((_loc6_ = _loc3_.getModel()) != null) {
                    _loc1_ = 1000;
                    _loc4_ = String(_loc6_.getString("furniture_extras"));
                    _loc5_ = parseInt(_loc4_);
                    _loc2_ = Math.floor(_loc5_ / _loc1_);
                    _loc7_ = _loc5_ % _loc1_;
                    var_4511 = _loc2_ > 9 ? 0 : _loc2_;
                    var_4509 = _loc7_ > 11 ? 0 : _loc7_;
                }
            }
        }
    }
}
