package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1678

    [SecureSWF(rename="true")]
    public class CommunityGoalProgressMessageEventParser implements IMessageParser {

        public function CommunityGoalProgressMessageEventParser() {
            super();
        }
        private var var_47: class_1678;

        public function get data(): class_1678 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1678(param1);
            return true;
        }
    }
}
