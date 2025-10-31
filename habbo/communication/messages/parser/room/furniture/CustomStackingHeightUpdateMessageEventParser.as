package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CustomStackingHeightUpdateMessageEventParser implements IMessageParser {

        public function CustomStackingHeightUpdateMessageEventParser() {
            super();
        }
        private var var_603: int;
        private var var_46: Number;

        public function get height(): Number {
            return var_46;
        }

        public function get furniId(): int {
            return var_603;
        }

        public function flush(): Boolean {
            var_603 = -1;
            var_46 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_603 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            var_46 = _loc2_ / 100;
            return true;
        }
    }
}
