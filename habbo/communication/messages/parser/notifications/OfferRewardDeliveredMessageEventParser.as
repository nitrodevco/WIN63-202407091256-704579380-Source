package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class OfferRewardDeliveredMessageEventParser implements IMessageParser {

        public function OfferRewardDeliveredMessageEventParser() {
            super();
        }
        private var var_489: String;
        private var var_390: int;
        private var var_363: String;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get contentType(): String {
            return var_489;
        }

        public function get classId(): int {
            return var_390;
        }

        public function get description(): String {
            return var_363;
        }

        public function flush(): Boolean {
            var_489 = null;
            var_390 = 0;
            _name = null;
            var_363 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_489 = param1.readString();
            var_390 = param1.readInteger();
            _name = param1.readString();
            var_363 = param1.readString();
            return true;
        }
    }
}
