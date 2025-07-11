package com.sulake.habbo.communication.messages.parser.room.camera {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1476 implements IMessageParser {

        public function class_1476() {
            super();
        }
        private var var_485: String = "";
        private var var_369: int = 0;

        public function get roomType(): String {
            return var_485;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function flush(): Boolean {
            var_485 = "";
            var_369 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_485 = param1.readString();
            var_369 = param1.readInteger();
            return true;
        }
    }
}
