package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage
    import com.sulake.room.utils.Vector3d

    public class RoomObjectTileCursorUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectTileCursorUpdateMessage(param1: Vector3d, param2: Number, param3: Boolean, param4: String, param5: Boolean = false) {
            super(param1, null);
            var_46 = param2;
            var_848 = param3;
            var_4575 = param4;
            var_4271 = param5;
        }
        private var var_46: Number;
        private var var_4575: String;
        private var var_848: Boolean;
        private var var_4271: Boolean;

        public function get height(): Number {
            return var_46;
        }

        public function get visible(): Boolean {
            return var_848;
        }

        public function get sourceEventId(): String {
            return var_4575;
        }

        public function get toggleVisibility(): Boolean {
            return var_4271;
        }
    }
}
