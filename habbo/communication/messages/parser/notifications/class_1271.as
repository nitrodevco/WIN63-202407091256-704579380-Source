package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.notifications.class_1681

    [SecureSWF(rename="true")]
    public class class_1271 implements IMessageParser {

        public function class_1271() {
            super();
        }
        private var var_47: class_1681;

        public function get data(): class_1681 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1681(param1);
            return true;
        }
    }
}
