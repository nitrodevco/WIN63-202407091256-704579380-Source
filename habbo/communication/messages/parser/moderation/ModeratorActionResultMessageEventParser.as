package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ModeratorActionResultMessageEventParser implements IMessageParser {

        public function ModeratorActionResultMessageEventParser() {
            super();
        }
        private var var_418: int;
        private var var_258: Boolean;

        public function get userId(): int {
            return var_418;
        }

        public function get success(): Boolean {
            return var_258;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            var_258 = param1.readBoolean();
            return true;
        }
    }
}
