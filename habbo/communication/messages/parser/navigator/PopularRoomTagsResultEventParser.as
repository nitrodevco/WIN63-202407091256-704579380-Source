package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1727

    [SecureSWF(rename="true")]
    public class PopularRoomTagsResultEventParser implements IMessageParser {

        public function PopularRoomTagsResultEventParser() {
            super();
        }
        private var var_47: class_1727;

        public function get data(): class_1727 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_47 = new class_1727(param1);
            return true;
        }
    }
}
