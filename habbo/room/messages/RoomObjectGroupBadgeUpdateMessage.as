package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectGroupBadgeUpdateMessage extends RoomObjectUpdateMessage {

        public static const BADGE_LOADED: String = "ROGBUM_BADGE_LOADED";

        public function RoomObjectGroupBadgeUpdateMessage(param1: String, param2: String) {
            super(null, null);
            var_372 = param1;
            _assetName = param2;
        }
        private var var_372: String;

        private var _assetName: String;

        public function get assetName(): String {
            return _assetName;
        }

        public function get badgeId(): String {
            return var_372;
        }
    }
}
