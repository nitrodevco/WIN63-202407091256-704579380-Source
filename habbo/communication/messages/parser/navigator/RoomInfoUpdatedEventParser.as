package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomInfoUpdatedEventParser implements IMessageParser {

        public function RoomInfoUpdatedEventParser() {
            super();
        }

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._flatId = param1.readInteger();
            return true;
        }
    }
}
