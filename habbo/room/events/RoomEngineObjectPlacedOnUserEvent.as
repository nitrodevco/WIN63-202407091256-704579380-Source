package com.sulake.habbo.room.events {
    public class RoomEngineObjectPlacedOnUserEvent extends RoomEngineObjectEvent {

        public function RoomEngineObjectPlacedOnUserEvent(param1: String, param2: int, param3: int, param4: int, param5: int, param6: int, param7: Boolean = false, param8: Boolean = false) {
            super(param1, param2, param3, param4, param7, param8);
            var_4337 = droppedObjectId;
            var_4499 = param6;
        }
        private var var_4337: int;
        private var var_4499: int;

        public function get droppedObjectId(): int {
            return var_4337;
        }

        public function get droppedObjectCategory(): int {
            return var_4499;
        }
    }
}
