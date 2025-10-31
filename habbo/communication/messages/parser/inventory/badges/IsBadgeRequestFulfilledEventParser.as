package com.sulake.habbo.communication.messages.parser.inventory.badges {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IsBadgeRequestFulfilledEventParser implements IMessageParser {

        public function IsBadgeRequestFulfilledEventParser() {
            super();
        }
        private var var_804: String;
        private var var_1494: Boolean;

        public function get requestCode(): String {
            return var_804;
        }

        public function get fulfilled(): Boolean {
            return var_1494;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_804 = param1.readString();
            var_1494 = param1.readBoolean();
            return true;
        }
    }
}
