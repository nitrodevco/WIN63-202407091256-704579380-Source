package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CollectibleMintTokenCountMessageEventParser implements IMessageParser {

        public function CollectibleMintTokenCountMessageEventParser() {
            super();
        }
        private var var_565: int = 0;

        public function get totalTokens(): int {
            return var_565;
        }

        public function flush(): Boolean {
            var_565 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_565 = param1.readInteger();
            return true;
        }
    }
}
