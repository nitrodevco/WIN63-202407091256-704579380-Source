package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1220 implements IMessageParser {

        public function class_1220() {
            super();
        }
        private var var_396: String = "";

        private var _productName: String = "";

        public function get productName(): String {
            return _productName;
        }

        public function get productDescription(): String {
            return var_396;
        }

        public function flush(): Boolean {
            var_396 = "";
            _productName = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_396 = param1.readString();
            _productName = param1.readString();
            return true;
        }
    }
}
