package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class EpicPopupMessageEventParser implements IMessageParser {

        public function EpicPopupMessageEventParser() {
            super();
        }
        private var var_512: String;

        public function get imageUri(): String {
            return var_512;
        }

        public function flush(): Boolean {
            var_512 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_512 = param1.readString();
            return true;
        }
    }
}
