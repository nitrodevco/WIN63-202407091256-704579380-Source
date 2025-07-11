package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.room.utils.ColorConverter
    import com.sulake.room.utils.IVector3d

    [SecureSWF(rename="true")]
    public class class_1300 {

        public function class_1300(param1: IMessageDataWrapper = null) {
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            var_671 = new Vector.<class_1684>();
            var_704 = new Vector.<class_1684>();
            var_120 = new Vector.<class_1688>();
            var_262 = new Vector.<class_1688>();
            var_265 = new Vector.<class_1688>();
            super();
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_671.push(new class_1684(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_704.push(new class_1684(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_120.push(new class_1688(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_262.push(new class_1688(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_265.push(new class_1688(param1));
                _loc3_++;
            }
        }
        private var var_671: Vector.<class_1684>;
        private var var_704: Vector.<class_1684>;
        private var var_120: Vector.<class_1688>;
        private var var_262: Vector.<class_1688>;
        private var var_265: Vector.<class_1688>;

        public function get baseParts(): Vector.<class_1684> {
            return var_671;
        }

        public function get layerParts(): Vector.<class_1684> {
            return var_704;
        }

        public function get badgeColors(): Vector.<class_1688> {
            return var_120;
        }

        public function get guildPrimaryColors(): Vector.<class_1688> {
            return var_262;
        }

        public function get guildSecondaryColors(): Vector.<class_1688> {
            return var_265;
        }

        public function findMatchingPrimaryColorId(param1: int): int {
            if (param1 < 0 || var_120.length <= 0 || var_120.length < param1 || var_262.length <= 0) {
                return 0;
            }
            return findClosestColor(var_120[param1], var_262);
        }

        public function findMatchingSecondaryColorId(param1: int): int {
            if (param1 < 0 || var_120.length <= 0 || var_120.length < param1 || var_265.length <= 0) {
                return 0;
            }
            return findClosestColor(var_120[param1], var_265);
        }

        private function findClosestColor(param1: class_1688, param2: Vector.<class_1688>): int {
            var _loc8_: int = 0;
            var _loc5_: IVector3d = null;
            var _loc6_: Number = NaN;
            var _loc4_: IVector3d = ColorConverter.rgb2CieLab(param1.color);
            var _loc7_: * = 0;
            var _loc3_: * = 1.7976931348623157e+308;
            _loc8_ = 0;
            while (_loc8_ < param2.length) {
                _loc5_ = ColorConverter.rgb2CieLab(param2[_loc8_].color);
                if ((_loc6_ = Math.pow(_loc4_.x - _loc5_.x, 2) + Math.pow(_loc4_.y - _loc5_.y, 2) + Math.pow(_loc4_.z - _loc5_.z, 2)) < _loc3_) {
                    _loc3_ = _loc6_;
                    _loc7_ = _loc8_;
                }
                _loc8_++;
            }
            return param2[_loc7_].id;
        }
    }
}
