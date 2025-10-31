package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomPropertyMessageEventParser implements IMessageParser {

        public function RoomPropertyMessageEventParser() {
            super();
        }
        private var var_551: String = null;
        private var var_444: String = null;
        private var var_370: String = null;
        private var var_616: String = null;

        public function get floorType(): String {
            return var_551;
        }

        public function get wallType(): String {
            return var_444;
        }

        public function get landscapeType(): String {
            return var_370;
        }

        public function get animatedLandscapeType(): String {
            return var_616;
        }

        public function flush(): Boolean {
            var_551 = null;
            var_444 = null;
            var_370 = null;
            var_616 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: String = param1.readString();
            var _loc2_: String = param1.readString();
            switch (_loc3_) {
                case "floor":
                    var_551 = _loc2_;
                    break;
                case "wallpaper":
                    var_444 = _loc2_;
                    break;
                case "landscape":
                    var_370 = _loc2_;
                    break;
                case "landscapeanim":
                    var_616 = _loc2_;
            }
            return true;
        }
    }
}
