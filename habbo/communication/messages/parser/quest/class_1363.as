package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1715

    [SecureSWF(rename="true")]
    public class class_1363 implements IMessageParser {

        public function class_1363() {
            super();
        }
        private var var_523: class_1715;
        private var var_1029: int;
        private var var_1400: int;

        public function get quest(): class_1715 {
            return var_523;
        }

        public function get easyQuestCount(): int {
            return var_1029;
        }

        public function get hardQuestCount(): int {
            return var_1400;
        }

        public function flush(): Boolean {
            var_523 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: Boolean = param1.readBoolean();
            if (_loc2_) {
                var_523 = new class_1715(param1);
                var_1029 = param1.readInteger();
                var_1400 = param1.readInteger();
            }
            return true;
        }
    }
}
