package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarExperienceUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarExperienceUpdateMessage(param1: int) {
            super();
            var_1467 = param1;
        }
        private var var_1467: int;

        public function get gainedExperience(): int {
            return var_1467;
        }
    }
}
