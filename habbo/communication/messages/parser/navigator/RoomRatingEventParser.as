package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomRatingEventParser implements IMessageParser {

        public function RoomRatingEventParser() {
            super();
        }
        private var var_1552: int;
        private var var_1557: Boolean;

        public function get rating(): int {
            return var_1552;
        }

        public function get canRate(): Boolean {
            return var_1557;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_1552 = param1.readInteger();
            this.var_1557 = param1.readBoolean();
            return true;
        }
    }
}
