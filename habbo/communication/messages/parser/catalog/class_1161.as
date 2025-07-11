package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1161 implements IMessageParser {

        public function class_1161() {
            super();
        }
        private var var_957: Boolean;

        private var _newFurniDataHash: String;

        public function get newFurniDataHash(): String {
            return _newFurniDataHash;
        }

        public function get instantlyRefreshCatalogue(): Boolean {
            return var_957;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_957 = param1.readBoolean();
            if (param1.bytesAvailable) {
                _newFurniDataHash = param1.readString();
            }
            return true;
        }
    }
}
