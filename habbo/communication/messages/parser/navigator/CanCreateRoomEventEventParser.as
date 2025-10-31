package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CanCreateRoomEventEventParser implements IMessageParser {

        public function CanCreateRoomEventEventParser() {
            super();
        }
        private var var_1520: Boolean;
        private var var_412: int;

        public function get canCreateEvent(): Boolean {
            return var_1520;
        }

        public function get errorCode(): int {
            return var_412;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_1520 = param1.readBoolean();
            this.var_412 = param1.readInteger();
            return true;
        }
    }
}
