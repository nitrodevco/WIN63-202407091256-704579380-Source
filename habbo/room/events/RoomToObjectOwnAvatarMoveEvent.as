package com.sulake.habbo.room.events {
    import com.sulake.room.events.RoomToObjectEvent
    import com.sulake.room.utils.IVector3d

    public class RoomToObjectOwnAvatarMoveEvent extends RoomToObjectEvent {

        public static const MOVE_TO: String = "ROAME_MOVE_TO";

        public function RoomToObjectOwnAvatarMoveEvent(param1: String, param2: IVector3d, param3: Boolean = false, param4: Boolean = false) {
            super(param1, param3, param4);
            var_1822 = param2;
        }
        private var var_1822: IVector3d;

        public function get targetLoc(): IVector3d {
            return var_1822;
        }
    }
}
