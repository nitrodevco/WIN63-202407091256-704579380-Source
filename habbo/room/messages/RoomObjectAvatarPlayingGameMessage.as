package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarPlayingGameMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarPlayingGameMessage(param1: Boolean = false) {
            super();
            _isPlayingGame = param1;
        }

        private var _isPlayingGame: Boolean;

        public function get isPlayingGame(): Boolean {
            return _isPlayingGame;
        }
    }
}
