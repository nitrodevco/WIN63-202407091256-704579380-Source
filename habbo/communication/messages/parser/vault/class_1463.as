package com.sulake.habbo.communication.messages.parser.vault {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1463 implements IMessageParser {

        public function class_1463() {
            super();
        }
        private var var_450: Boolean;
        private var var_548: int;
        private var var_594: int;

        public function get isUnlocked(): Boolean {
            return var_450;
        }

        public function get totalBalance(): int {
            return var_548;
        }

        public function get withdrawBalance(): int {
            return var_594;
        }

        public function flush(): Boolean {
            var_450 = false;
            var_548 = 0;
            var_594 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_450 = param1.readBoolean();
            var_548 = param1.readInteger();
            var_594 = param1.readInteger();
            return true;
        }
    }
}
