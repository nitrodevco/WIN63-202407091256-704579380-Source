package com.sulake.habbo.room.events {
    import com.sulake.room.events.RoomObjectMouseEvent
    import com.sulake.room.object.IRoomObject

    public class RoomObjectTileMouseEvent extends RoomObjectMouseEvent {

        public function RoomObjectTileMouseEvent(param1: String, param2: IRoomObject, param3: String, param4: Number, param5: Number, param6: Number, param7: Boolean = false, param8: Boolean = false, param9: Boolean = false, param10: Boolean = false, param11: Boolean = false, param12: Boolean = false) {
            super(param1, param2, param3, param7, param8, param9, param10, param11, param12);
            var_4094 = param4;
            var_3990 = param5;
            var_3975 = param6;
        }
        private var var_4094: Number;
        private var var_3990: Number;
        private var var_3975: Number;

        public function get tileX(): Number {
            return var_4094;
        }

        public function get tileY(): Number {
            return var_3990;
        }

        public function get tileZ(): Number {
            return var_3975;
        }

        public function get tileXAsInt(): int {
            return var_4094 + 0.499;
        }

        public function get tileYAsInt(): int {
            return var_3990 + 0.499;
        }

        public function get tileZAsInt(): int {
            return var_3975 + 0.499;
        }
    }
}
