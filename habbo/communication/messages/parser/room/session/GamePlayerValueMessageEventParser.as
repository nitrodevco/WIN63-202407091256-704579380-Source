package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GamePlayerValueMessageEventParser implements IMessageParser {

        public function GamePlayerValueMessageEventParser() {
            super();
        }
        private var var_418: int = 0;

        private var _value: int = 0;

        public function get value(): int {
            return _value;
        }

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            _value = param1.readInteger();
            return true;
        }
    }
}
