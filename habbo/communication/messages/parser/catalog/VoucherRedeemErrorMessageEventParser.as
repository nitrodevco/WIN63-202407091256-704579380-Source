package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class VoucherRedeemErrorMessageEventParser implements IMessageParser {

        public function VoucherRedeemErrorMessageEventParser() {
            super();
        }
        private var var_412: String = "";

        public function get errorCode(): String {
            return var_412;
        }

        public function flush(): Boolean {
            var_412 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_412 = param1.readString();
            return true;
        }
    }
}
