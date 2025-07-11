package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_1638

    [SecureSWF(rename="true")]
    public class class_1134 implements IMessageParser {

        public function class_1134() {
            super();
        }
        private var var_1123: class_1638;
        private var var_1284: class_1638;

        public function get resultData(): class_1638 {
            return var_1123;
        }

        public function get otherResultData(): class_1638 {
            return var_1284;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1123 = parseResultData(param1);
            var_1284 = parseResultData(param1);
            return true;
        }

        private function parseResultData(param1: IMessageDataWrapper): class_1638 {
            var _loc2_: int = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            var _loc4_: String = param1.readString();
            var _loc7_: int = param1.readInteger();
            var _loc6_: String = param1.readString();
            var _loc5_: int = param1.readInteger();
            var _loc8_: Boolean = param1.readBoolean();
            return new class_1638(_loc2_, _loc3_, _loc4_, _loc7_, _loc6_, _loc5_, _loc8_);
        }
    }
}
