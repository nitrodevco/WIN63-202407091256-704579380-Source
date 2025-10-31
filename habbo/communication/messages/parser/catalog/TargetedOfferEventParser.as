package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1725

    [SecureSWF(rename="true")]
    public class TargetedOfferEventParser implements IMessageParser {

        public function TargetedOfferEventParser() {
            super();
        }
        private var var_47: class_1725;

        public function get data(): class_1725 {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1725().parse(param1);
            return true;
        }
    }
}
