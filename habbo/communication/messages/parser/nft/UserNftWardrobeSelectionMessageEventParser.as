package com.sulake.habbo.communication.messages.parser.nft {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class UserNftWardrobeSelectionMessageEventParser implements IMessageParser {

        public function UserNftWardrobeSelectionMessageEventParser() {
            super();
        }
        private var var_1491: String;
        private var var_384: String;
        private var var_366: String;

        public function get currentTokenId(): String {
            return var_1491;
        }

        public function get fallbackFigureString(): String {
            return var_384;
        }

        public function get fallbackFigureGender(): String {
            return var_366;
        }

        public function flush(): Boolean {
            var_384 = "";
            var_366 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1491 = param1.readString();
            var_384 = param1.readString();
            var_366 = param1.readString();
            return true;
        }
    }
}
