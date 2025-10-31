package com.sulake.habbo.communication.messages.parser.room.layout {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomEntryTileMessageEventParser implements IMessageParser {

        public function RoomEntryTileMessageEventParser() {
            super();
        }
        private var var_31: int;
        private var var_28: int;
        private var var_643: uint;

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        public function get dir(): uint {
            return var_643;
        }

        public function flush(): Boolean {
            var_31 = 0;
            var_28 = 0;
            var_643 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_31 = param1.readInteger();
            var_28 = param1.readInteger();
            var_643 = param1.readInteger();
            return true;
        }
    }
}
