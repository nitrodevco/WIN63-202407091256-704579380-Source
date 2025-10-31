package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class YoutubeDisplayPlaylistsMessageEventParser implements IMessageParser {

        public function YoutubeDisplayPlaylistsMessageEventParser() {
            super();
        }
        private var var_603: int;
        private var var_315: Vector.<class_1728>;
        private var var_1096: String;

        public function get furniId(): int {
            return var_603;
        }

        public function get playlists(): Vector.<class_1728> {
            return var_315;
        }

        public function get selectedPlaylistId(): String {
            return var_1096;
        }

        public function flush(): Boolean {
            var_315 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc2_: String = null;
            var _loc6_: String = null;
            var _loc5_: String = null;
            var_603 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            var_315 = new Vector.<class_1728>(0);
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = param1.readString();
                _loc6_ = param1.readString();
                _loc5_ = param1.readString();
                var_315.push(new class_1728(_loc2_, _loc6_, _loc5_));
                _loc4_++;
            }
            var_1096 = param1.readString();
            return true;
        }
    }
}
