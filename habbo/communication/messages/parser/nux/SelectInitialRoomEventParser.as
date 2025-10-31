package com.sulake.habbo.communication.messages.parser.nux {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class SelectInitialRoomEventParser implements IMessageParser {

        public function SelectInitialRoomEventParser() {
            super();
        }
        private var var_369: int;

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _status = param1.readShort();
            var_369 = param1.readInteger();
            return true;
        }
    }
}
