package com.sulake.habbo.communication.messages.parser.room.action {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class DanceMessageEventParser implements IMessageParser {

        public function DanceMessageEventParser() {
            super();
        }
        private var var_418: int = 0;
        private var var_1021: int = 0;

        public function get userId(): int {
            return var_418;
        }

        public function get danceStyle(): int {
            return var_1021;
        }

        public function flush(): Boolean {
            var_418 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            var_1021 = param1.readInteger();
            return true;
        }
    }
}
