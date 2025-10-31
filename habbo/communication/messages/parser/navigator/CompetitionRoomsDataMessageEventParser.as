package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1665

    [SecureSWF(rename="true")]
    public class CompetitionRoomsDataMessageEventParser implements IMessageParser {

        public function CompetitionRoomsDataMessageEventParser() {
            super();
        }
        private var var_47: class_1665;

        public function get data(): class_1665 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1665(param1);
            return true;
        }
    }
}
