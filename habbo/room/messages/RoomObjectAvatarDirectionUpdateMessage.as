package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage
    import com.sulake.room.utils.IVector3d

    public class RoomObjectAvatarDirectionUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectAvatarDirectionUpdateMessage(param1: IVector3d, param2: IVector3d, param3: int) {
            super(param1, param2);
            var_1146 = param3;
        }
        private var var_1146: int;

        public function get dirHead(): int {
            return var_1146;
        }
    }
}
