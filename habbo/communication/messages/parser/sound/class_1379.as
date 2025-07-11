package com.sulake.habbo.communication.messages.parser.sound {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1379 implements IMessageParser {

        public function class_1379() {
            super();
        }
        private var var_614: int;
        private var var_402: int;
        private var var_564: int;
        private var var_579: int;
        private var var_601: int;

        public function get currentSongId(): int {
            return var_614;
        }

        public function get currentPosition(): int {
            return var_402;
        }

        public function get nextSongId(): int {
            return var_564;
        }

        public function get nextPosition(): int {
            return var_579;
        }

        public function get syncCount(): int {
            return var_601;
        }

        public function flush(): Boolean {
            var_614 = -1;
            var_402 = -1;
            var_564 = -1;
            var_579 = -1;
            var_601 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_614 = param1.readInteger();
            var_402 = param1.readInteger();
            var_564 = param1.readInteger();
            var_579 = param1.readInteger();
            var_601 = param1.readInteger();
            return true;
        }
    }
}
