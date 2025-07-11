package com.sulake.habbo.communication.messages.parser.avatar {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1610 implements IMessageParser {

        public function class_1610() {
            super();
        }
        private var var_426: String;
        private var var_129: String;

        public function get figure(): String {
            return var_426;
        }

        public function get gender(): String {
            return var_129;
        }

        public function flush(): Boolean {
            var_426 = "";
            var_129 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_426 = param1.readString();
            var_129 = param1.readString();
            if (var_129) {
                var_129 = var_129.toUpperCase();
            }
            return true;
        }
    }
}
