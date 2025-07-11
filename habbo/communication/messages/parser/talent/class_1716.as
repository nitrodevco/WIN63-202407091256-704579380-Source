package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.utils.class_419

    [SecureSWF(rename="true")]
    public class class_1716 {

        public static const STATE_LOCKED: int = 0;

        public static const const_129: int = 1;

        public static const const_241: int = 2;

        public function class_1716() {
            super();
        }
        private var var_169: int;

        private var var_99: Vector.<class_1783>;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get levels(): Vector.<class_1783> {
            return var_99;
        }

        public function get progressPerLevel(): Number {
            if (var_99.length > 0) {
                return 1 / var_99.length;
            }
            return 0;
        }

        public function get totalProgress(): Number {
            var _loc1_: Number = NaN;
            if (var_99.length > 0) {
                _loc1_ = var_99[var_169].levelProgress;
                return class_419.clamp(var_169 * progressPerLevel + _loc1_ * progressPerLevel);
            }
            return 0;
        }

        public function get progressForCurrentLevel(): Number {
            if (var_99.length > 0) {
                return var_169 * progressPerLevel;
            }
            return 0;
        }

        public function parse(param1: IMessageDataWrapper): void {
            var _loc4_: int = 0;
            var _loc3_: class_1783 = null;
            _name = param1.readString();
            var_99 = new Vector.<class_1783>();
            var _loc2_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_ = new class_1783();
                _loc3_.parse(param1);
                if (_loc3_.state == 1) {
                    var_169 = _loc4_;
                }
                var_99.push(_loc3_);
                _loc4_++;
            }
        }

        public function findTaskByAchievementId(param1: int): class_1771 {
            var _loc3_: class_1771 = null;
            var _loc4_: * = null;
            for each(var _loc2_ in var_99) {
                if (_loc2_.state != 0) {
                    _loc3_ = _loc2_.findTaskByAchievementId(param1);
                    if (_loc3_ != null) {
                        _loc4_ = _loc3_;
                    }
                }
            }
            return _loc4_;
        }

        public function removeFirstLevel(): void {
            var_99.shift();
            var_169 = Math.max(0, var_169 - 1);
        }
    }
}
