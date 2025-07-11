package com.sulake.habbo.communication.messages.parser.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1660

    [SecureSWF(rename="true")]
    public class class_1311 implements IMessageParser {

        public function class_1311() {
            super();
        }
        private var var_380: class_1660;

        public function get def(): class_1660 {
            return var_380;
        }

        public function flush(): Boolean {
            var_380 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_380 = new class_1660(param1);
            return true;
        }
    }
}
