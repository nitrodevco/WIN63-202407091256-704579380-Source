package com.sulake.habbo.room.messages {
    import com.sulake.room.utils.IVector3d

    public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage {

        public function RoomObjectAvatarUpdateMessage(param1: IVector3d, param2: IVector3d, param3: IVector3d, param4: int, param5: Boolean, param6: Number, param7: Number = NaN, param8: * = false) {
            super(param1, param2, param3, param7, false, param8);
            var_1146 = param4;
            var_1168 = param5;
            var_3727 = param6;
        }
        private var var_1146: int;
        private var var_1168: Boolean;
        private var var_3727: Number;

        public function get dirHead(): int {
            return var_1146;
        }

        public function get canStandUp(): Boolean {
            return var_1168;
        }

        public function get baseY(): Number {
            return var_3727;
        }
    }
}
