package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarExpressionUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarExpressionUpdateMessage(param1: int = -1) {
            super();
            var_404 = param1;
        }
        private var var_404: int = -1;

        public function get expressionType(): int {
            return var_404;
        }
    }
}
