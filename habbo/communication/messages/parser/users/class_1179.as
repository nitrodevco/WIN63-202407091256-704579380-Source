package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.users.class_1199

    [SecureSWF(rename="true")]
    public class class_1179 implements IMessageParser {

        public function class_1179() {
            super();
        }
        private var var_47: class_1199;

        public function get data(): class_1199 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1199(param1);
            return true;
        }
    }
}
