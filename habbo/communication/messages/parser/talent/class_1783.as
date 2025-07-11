package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.utils.class_419

    [SecureSWF(rename="true")]
    public class class_1783 {

        public function class_1783() {
            var_239 = new Vector.<class_1771>();
            var_266 = new Vector.<class_1756>();
            var_270 = new Vector.<class_1700>();
            super();
        }
        private var var_360: int;
        private var var_149: int;
        private var var_239: Vector.<class_1771>;
        private var var_266: Vector.<class_1756>;
        private var var_270: Vector.<class_1700>;

        public function get level(): int {
            return var_360;
        }

        public function set level(param1: int): void {
            var_360 = param1;
        }

        public function get state(): int {
            return var_149;
        }

        public function set state(param1: int): void {
            var_149 = param1;
        }

        public function get tasks(): Vector.<class_1771> {
            return var_239;
        }

        public function get rewardPerks(): Vector.<class_1756> {
            return var_266;
        }

        public function get rewardProducts(): Vector.<class_1700> {
            return var_270;
        }

        public function get rewardCount(): int {
            return var_266.length + var_270.length;
        }

        public function get levelProgress(): Number {
            var _loc2_: Number = 1 / var_239.length;
            var _loc3_: Number = 0;
            for each(var _loc1_ in var_239) {
                if (_loc1_.state == 2) {
                    _loc3_ += _loc2_;
                }
            }
            return class_419.clamp(_loc3_);
        }

        public function parse(param1: IMessageDataWrapper): void {
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var_360 = param1.readInteger();
            var_149 = param1.readInteger();
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_239.push(new class_1771(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_266.push(new class_1756(param1));
                _loc3_++;
            }
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_270.push(new class_1700(param1));
                _loc3_++;
            }
        }

        public function findTaskByAchievementId(param1: int): class_1771 {
            for each(var _loc2_ in var_239) {
                if (_loc2_.achievementId == param1) {
                    return _loc2_;
                }
            }
            return null;
        }
    }
}
