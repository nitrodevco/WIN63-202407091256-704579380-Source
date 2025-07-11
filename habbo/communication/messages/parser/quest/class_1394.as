package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1673

    [SecureSWF(rename="true")]
    public class class_1394 implements IMessageParser {

        public function class_1394() {
            super();
        }
        private var var_47: class_1673;

        public function get data(): class_1673 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1673(param1);
            return true;
        }
    }
}
