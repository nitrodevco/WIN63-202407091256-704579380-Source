package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage
    import com.sulake.room.utils.IVector3d

    public class RoomObjectHeightUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectHeightUpdateMessage(param1: IVector3d, param2: IVector3d, param3: Number) {
            super(param1, param2);
            var_46 = param3;
        }
        private var var_46: Number;

        public function get height(): Number {
            return var_46;
        }
    }
}
