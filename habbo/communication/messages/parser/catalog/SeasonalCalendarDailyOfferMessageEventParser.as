package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1501

    [SecureSWF(rename="true")]
    public class SeasonalCalendarDailyOfferMessageEventParser implements IMessageParser {

        public function SeasonalCalendarDailyOfferMessageEventParser() {
            super();
        }
        private var var_562: int;
        private var var_598: class_1501;

        public function get pageId(): int {
            return var_562;
        }

        public function get offerData(): class_1501 {
            return var_598;
        }

        public function flush(): Boolean {
            var_562 = -1;
            var_598 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_562 = param1.readInteger();
            var_598 = new class_1501(param1);
            return true;
        }
    }
}
