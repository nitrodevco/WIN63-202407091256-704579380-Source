package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1731 {

        public static const const_52: int = 0;

        public static const const_253: int = 1;

        public static const const_223: int = 2;

        public static const const_38: int = 4;

        public static const const_300: int = 5;

        public function class_1731(param1: IMessageDataWrapper) {
            super();
            var_1309 = param1.readInteger();
            var_765 = param1.readInteger();
            var_803 = param1.readInteger();
        }
        private var var_1309: int;
        private var var_765: int;
        private var var_803: int;

        public function get whoCanMute(): int {
            return var_1309;
        }

        public function get whoCanKick(): int {
            return var_765;
        }

        public function get whoCanBan(): int {
            return var_803;
        }
    }
}
