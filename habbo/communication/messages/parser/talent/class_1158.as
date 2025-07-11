package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1158 implements IMessageParser {

        public function class_1158() {
            super();
        }
        private var var_430: String;
        private var var_360: int;
        private var var_266: Vector.<class_1756>;
        private var var_270: Vector.<class_1700>;

        public function get talentTrackName(): String {
            return var_430;
        }

        public function get level(): int {
            return var_360;
        }

        public function get rewardPerks(): Vector.<class_1756> {
            return var_266;
        }

        public function get rewardProducts(): Vector.<class_1700> {
            return var_270;
        }

        public function flush(): Boolean {
            var_430 = null;
            var_266 = null;
            var_270 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_430 = param1.readString();
            var_360 = param1.readInteger();
            var_266 = new Vector.<class_1756>();
            var _loc4_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc4_) {
                var_266.push(new class_1756(param1));
                _loc3_++;
            }
            var_270 = new Vector.<class_1700>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_270.push(new class_1700(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
