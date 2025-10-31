package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ElementPointerMessageEventParser implements IMessageParser {

        public function ElementPointerMessageEventParser() {
            super();
        }

        private var _key: String;

        public function get key(): String {
            return _key;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _key = param1.readString();
            return true;
        }
    }
}
