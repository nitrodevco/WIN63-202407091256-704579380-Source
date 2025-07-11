package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage

    import flash.display.BitmapData

    public class RoomObjectRoomAdUpdateMessage extends RoomObjectUpdateMessage {

        public static const ROOM_AD_ACTIVATE: String = "RORUM_ROOM_AD_ACTIVATE";

        public static const ROOM_BILLBOARD_IMAGE_LOADED: String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADED";

        public static const ROOM_BILLBOARD_LOADING_FAILED: String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED";

        public function RoomObjectRoomAdUpdateMessage(param1: String, param2: String, param3: String, param4: int = -1, param5: BitmapData = null) {
            super(null, null);
            var_329 = param1;
            _asset = param2;
            var_3950 = param3;
            var_455 = param4;
            _bitmapData = param5;
        }
        private var var_329: String;
        private var var_3950: String;

        private var var_455: int;

        private var _asset: String;

        public function get asset(): String {
            return _asset;
        }

        private var _bitmapData: BitmapData;

        public function get bitmapData(): BitmapData {
            return _bitmapData;
        }

        public function get type(): String {
            return var_329;
        }

        public function get clickUrl(): String {
            return var_3950;
        }

        public function get objectId(): int {
            return var_455;
        }
    }
}
