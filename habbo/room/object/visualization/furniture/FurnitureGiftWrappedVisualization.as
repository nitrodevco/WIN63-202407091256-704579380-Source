package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.IRoomObject
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.utils.IRoomGeometry

    public class FurnitureGiftWrappedVisualization extends FurnitureVisualization {

        public function FurnitureGiftWrappedVisualization() {
            super();
        }
        private var var_4511: int = 0;
        private var var_4509: int = 0;

        override public function update(param1: IRoomGeometry, param2: int, param3: Boolean, param4: Boolean): void {
            updateTypes();
            super.update(param1, param2, param3, param4);
        }

        override protected function getFrameNumber(param1: int, param2: int): int {
            if (param2 <= 1) {
                return var_4511;
            }
            return var_4509;
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

        private function updateTypes(): void {
            var _loc5_: IRoomObjectModel = null;
            var _loc1_: int = 0;
            var _loc3_: String = null;
            var _loc4_: int = 0;
            var _loc2_: IRoomObject = object;
            if (_loc2_ != null) {
                if ((_loc5_ = _loc2_.getModel()) != null) {
                    _loc1_ = 1000;
                    _loc3_ = String(_loc5_.getString("furniture_extras"));
                    _loc4_ = parseInt(_loc3_);
                    var_4511 = Math.floor(_loc4_ / _loc1_);
                    var_4509 = _loc4_ % _loc1_;
                }
            }
        }
    }
}
