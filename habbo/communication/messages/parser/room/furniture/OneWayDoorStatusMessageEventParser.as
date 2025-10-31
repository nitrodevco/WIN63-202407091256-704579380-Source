package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class OneWayDoorStatusMessageEventParser implements IMessageParser {

        public function OneWayDoorStatusMessageEventParser() {
            super();
        }
        private var var_280: int;

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        public function get id(): int {
            return var_280;
        }

        public function flush(): Boolean {
            var_280 = -1;
            _status = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_280 = param1.readInteger();
            _status = param1.readInteger();
            return true;
        }
    }
}
