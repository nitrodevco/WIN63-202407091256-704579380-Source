package com.sulake.habbo.communication.messages.parser.room.action {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CarryObjectMessageEventParser implements IMessageParser {

        public function CarryObjectMessageEventParser() {
            super();
        }
        private var var_418: int = 0;
        private var var_125: int;

        public function get userId(): int {
            return var_418;
        }

        public function get itemType(): int {
            return var_125;
        }

        public function flush(): Boolean {
            var_418 = 0;
            var_125 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            var_125 = param1.readInteger();
            return true;
        }
    }
}
