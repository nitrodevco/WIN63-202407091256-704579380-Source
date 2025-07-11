package com.sulake.habbo.room.events {
    import com.sulake.room.object.IRoomObject

    public class RoomObjectSamplePlaybackEvent extends RoomObjectFurnitureActionEvent {

        public static const ROOM_OBJECT_INITIALIZED: String = "ROPSPE_ROOM_OBJECT_INITIALIZED";

        public static const ROOM_OBJECT_DISPOSED: String = "ROPSPE_ROOM_OBJECT_DISPOSED";

        public static const PLAY_SAMPLE: String = "ROPSPE_PLAY_SAMPLE";

        public static const CHANGE_PITCH: String = "ROPSPE_CHANGE_PITCH";

        public function RoomObjectSamplePlaybackEvent(param1: String, param2: IRoomObject, param3: int, param4: Number = 1, param5: Boolean = false, param6: Boolean = false) {
            super(param1, param2, param5, param6);
            var_3468 = param3;
            var_3279 = param4;
        }
        private var var_3468: int;
        private var var_3279: Number;

        public function get sampleId(): int {
            return var_3468;
        }

        public function get pitch(): Number {
            return var_3279;
        }
    }
}
