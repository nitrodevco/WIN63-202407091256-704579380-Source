package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RentableSpaceRentOkMessageEventParser implements IMessageParser {

        public function RentableSpaceRentOkMessageEventParser() {
            super();
        }

        private var _expiryTime: int;

        public function get expiryTime(): int {
            return _expiryTime;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _expiryTime = param1.readInteger();
            return true;
        }
    }
}
