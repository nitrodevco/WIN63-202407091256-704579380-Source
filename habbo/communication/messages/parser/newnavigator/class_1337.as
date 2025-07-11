package com.sulake.habbo.communication.messages.parser.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1652

    [SecureSWF(rename="true")]
    public class class_1337 implements IMessageParser {

        public function class_1337() {
            super();
        }
        private var var_409: class_1652;

        public function get searchResult(): class_1652 {
            return var_409;
        }

        public function flush(): Boolean {
            var_409 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_409 = new class_1652(param1);
            return true;
        }
    }
}
