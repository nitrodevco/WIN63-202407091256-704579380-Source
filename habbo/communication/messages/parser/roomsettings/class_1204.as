package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1204 implements IMessageParser {

        public static const const_383: int = 1;

        public static const const_39: int = 2;

        public static const const_321: int = 3;

        public static const const_195: int = 4;

        public static const const_18: int = 5;

        public static const const_108: int = 6;

        public static const const_397: int = 7;

        public static const const_207: int = 8;

        public static const const_226: int = 9;

        public static const const_351: int = 10;

        public static const const_20: int = 11;

        public static const const_201: int = 12;

        public static const const_267: int = 13;

        public function class_1204() {
            super();
        }
        private var var_369: int;
        private var var_412: int;
        private var var_1228: String;

        public function get roomId(): int {
            return var_369;
        }

        public function get errorCode(): int {
            return var_412;
        }

        public function get info(): String {
            return var_1228;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_369 = param1.readInteger();
            var_412 = param1.readInteger();
            var_1228 = param1.readString();
            return true;
        }

        public function flush(): Boolean {
            return true;
        }
    }
}
