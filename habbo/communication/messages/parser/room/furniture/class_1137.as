package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1137 implements IMessageParser {

        public function class_1137() {
            super();
        }
        private var var_369: int;
        private var var_437: int;

        private var _roomName: String;

        public function get roomName(): String {
            return _roomName;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function get messageCount(): int {
            return var_437;
        }

        public function flush(): Boolean {
            var_369 = -1;
            _roomName = "";
            var_437 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_369 = param1.readInteger();
            _roomName = param1.readString();
            var_437 = param1.readInteger();
            return true;
        }
    }
}
