package com.sulake.habbo.communication.messages.parser.sound {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.sound.class_1648

    [SecureSWF(rename="true")]
    public class PlayListSongAddedMessageEventParser implements IMessageParser {

        public function PlayListSongAddedMessageEventParser() {
            super();
        }
        private var var_460: class_1648;

        public function get entry(): class_1648 {
            return var_460;
        }

        public function flush(): Boolean {
            var_460 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc5_: int = param1.readInteger();
            var _loc4_: int = param1.readInteger();
            var _loc2_: String = param1.readString();
            var _loc3_: String = param1.readString();
            var_460 = new class_1648(_loc5_, _loc4_, _loc2_, _loc3_);
            return true;
        }
    }
}
