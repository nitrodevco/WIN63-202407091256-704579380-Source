package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1715

    [SecureSWF(rename="true")]
    public class QuestCompletedMessageEventParser implements IMessageParser {

        public function QuestCompletedMessageEventParser() {
            super();
        }
        private var var_549: class_1715;
        private var var_1164: Boolean;

        public function get questData(): class_1715 {
            return var_549;
        }

        public function get showDialog(): Boolean {
            return var_1164;
        }

        public function flush(): Boolean {
            var_549 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_549 = new class_1715(param1);
            var_1164 = param1.readBoolean();
            return true;
        }
    }
}
