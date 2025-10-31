package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CollectibleWalletAddressesMessageEventParser implements IMessageParser {

        public function CollectibleWalletAddressesMessageEventParser() {
            super();
        }
        private var var_241: String;
        private var var_228: Array;

        public function get walletAddresses(): Array {
            return var_228;
        }

        public function get stardustWalletAddress(): String {
            return var_241;
        }

        public function flush(): Boolean {
            var_241 = null;
            var_228 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_241 = param1.readString();
            var_228 = [];
            if (var_241 != "") {
                var_228.push(var_241);
            }
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_228.push(param1.readString());
                _loc3_++;
            }
            return true;
        }
    }
}
