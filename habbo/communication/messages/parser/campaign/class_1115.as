package com.sulake.habbo.communication.messages.parser.campaign {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1115 implements IMessageParser {

        public function class_1115() {
            super();
        }
        private var var_482: Boolean;
        private var var_636: String;

        private var var_592: String;

        private var _productName: String;

        public function get productName(): String {
            return _productName;
        }

        public function get doorOpened(): Boolean {
            return var_482;
        }

        public function get customImage(): String {
            return var_636;
        }

        public function get furnitureClassName(): String {
            return var_592;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_482 = param1.readBoolean();
            _productName = param1.readString();
            var_636 = param1.readString();
            var_592 = param1.readString();
            return true;
        }

        public function flush(): Boolean {
            var_482 = false;
            _productName = null;
            var_636 = null;
            var_592 = null;
            return true;
        }
    }
}
