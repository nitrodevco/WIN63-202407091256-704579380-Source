package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1715

    [SecureSWF(rename="true")]
    public class class_1536 implements IMessageParser {

        public function class_1536() {
            super();
        }
        private var var_1152: Boolean;
        private var var_523: class_1715;

        public function get expired(): Boolean {
            return var_1152;
        }

        public function get quest(): class_1715 {
            return var_523;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1152 = param1.readBoolean();
            var_523 = new class_1715(param1);
            return true;
        }
    }
}
