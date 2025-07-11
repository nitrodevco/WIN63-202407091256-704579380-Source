package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage {

        public static const ADD_MASK: String = "RORMUM_ADD_MASK";

        public static const REMOVE_MASK: String = "RORMUM_ADD_MASK";

        public static const MASK_TYPE_DOOR: String = "door";

        public static const MASK_CATEGORY_WINDOW: String = "window";

        public static const MASK_CATEGORY_HOLE: String = "hole";

        public function RoomObjectRoomMaskUpdateMessage(param1: String, param2: String, param3: String = null, param4: IVector3d = null, param5: String = "window") {
            super(null, null);
            var_329 = param1;
            var_4284 = param2;
            var_4637 = param3;
            if (param4 != null) {
                var_4282 = new Vector3d(param4.x, param4.y, param4.z);
            }
            var_4577 = param5;
        }
        private var var_329: String = "";
        private var var_4284: String = "";
        private var var_4637: String = "";
        private var var_4282: Vector3d = null;
        private var var_4577: String = "window";

        public function get type(): String {
            return var_329;
        }

        public function get maskId(): String {
            return var_4284;
        }

        public function get maskType(): String {
            return var_4637;
        }

        public function get maskLocation(): IVector3d {
            return var_4282;
        }

        public function get maskCategory(): String {
            return var_4577;
        }
    }
}
