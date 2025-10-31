package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1748

    [SecureSWF(rename="true")]
    public class BannedUsersFromRoomEventParser implements IMessageParser {

        public function BannedUsersFromRoomEventParser() {
            super();
        }
        private var var_369: int;
        private var var_657: Array;

        public function get roomId(): int {
            return var_369;
        }

        public function get bannedUsers(): Array {
            return var_657;
        }

        public function flush(): Boolean {
            var_657 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_369 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_657.push(new class_1748(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
