package com.sulake.habbo.communication.messages.parser.poll {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PollOfferEventParser implements IMessageParser {

        public function PollOfferEventParser() {
            super();
        }
        private var var_280: int = -1;
        private var var_329: String = "";
        private var var_449: String = "";

        private var _headline: String = "";

        public function get headline(): String {
            return _headline;
        }

        public function get id(): int {
            return var_280;
        }

        public function get type(): String {
            return var_329;
        }

        public function get summary(): String {
            return var_449;
        }

        public function flush(): Boolean {
            var_280 = -1;
            var_329 = "";
            var_449 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_280 = param1.readInteger();
            var_329 = param1.readString();
            _headline = param1.readString();
            var_449 = param1.readString();
            return true;
        }
    }
}
