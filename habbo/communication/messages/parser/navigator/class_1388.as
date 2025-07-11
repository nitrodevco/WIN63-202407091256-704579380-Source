package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1751

    [SecureSWF(rename="true")]
    public class class_1388 implements IMessageParser {

        public function class_1388() {
            super();
        }
        private var var_47: class_1751;

        public function get data(): class_1751 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1751(param1);
            return true;
        }
    }
}
