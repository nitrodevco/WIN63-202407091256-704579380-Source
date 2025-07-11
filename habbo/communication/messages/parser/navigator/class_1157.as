package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1680

    [SecureSWF(rename="true")]
    public class class_1157 implements IMessageParser {

        public function class_1157() {
            super();
        }
        private var var_47: class_1680;

        public function get data(): class_1680 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_47 = new class_1680(param1);
            return true;
        }
    }
}
