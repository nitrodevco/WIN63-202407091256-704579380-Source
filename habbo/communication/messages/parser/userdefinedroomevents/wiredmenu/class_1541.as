package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class class_1541 implements IMessageParser {

        public function class_1541() {
            super();
        }
        private var var_468: int;

        public function get allVariablesHash(): int {
            return var_468;
        }

        public function flush(): Boolean {
            var_468 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_468 = param1.readInteger();
            return true;
        }
    }
}
