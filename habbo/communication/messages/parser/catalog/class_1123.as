package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1501

    [SecureSWF(rename="true")]
    public class class_1123 implements IMessageParser {

        public function class_1123() {
            super();
        }
        private var var_598: class_1501;

        public function get offerData(): class_1501 {
            return var_598;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_598 = new class_1501(param1);
            return true;
        }
    }
}
