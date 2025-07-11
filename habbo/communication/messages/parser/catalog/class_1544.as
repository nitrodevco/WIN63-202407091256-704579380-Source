package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1544 implements IMessageParser {

        public function class_1544() {
            super();
        }
        private var var_408: Boolean;
        private var var_748: String;
        private var var_826: String;
        private var var_1011: int;

        public function get available(): Boolean {
            return var_408;
        }

        public function get pricePointUrl(): String {
            return var_748;
        }

        public function get market(): String {
            return var_826;
        }

        public function get lengthInDays(): int {
            return var_1011;
        }

        public function flush(): Boolean {
            var_408 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_748 = param1.readString();
            if (var_748 != "") {
                var_408 = true;
            }
            var_826 = param1.readString();
            var_1011 = param1.readInteger();
            return true;
        }
    }
}
