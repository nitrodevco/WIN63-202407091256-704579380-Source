package com.sulake.habbo.communication.messages.parser.talent {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1313 implements IMessageParser {

        public function class_1313() {
            super();
        }
        private var var_430: String;
        private var var_360: int;
        private var var_1100: int;

        public function get talentTrackName(): String {
            return var_430;
        }

        public function get level(): int {
            return var_360;
        }

        public function get maxLevel(): int {
            return var_1100;
        }

        public function flush(): Boolean {
            var_430 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_430 = param1.readString();
            var_360 = param1.readInteger();
            var_1100 = param1.readInteger();
            return true;
        }
    }
}
