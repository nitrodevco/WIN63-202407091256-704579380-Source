package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1667

    [SecureSWF(rename="true")]
    public class class_1287 implements IMessageParser {

        public function class_1287() {
            super();
        }
        private var var_47: class_1667;

        public function get data(): class_1667 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1667(param1);
            return true;
        }
    }
}
