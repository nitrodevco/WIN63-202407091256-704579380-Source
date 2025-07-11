package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1732 {

        public static const const_330: int = 0;

        public static const const_361: int = 1;

        public static const const_194: int = 0;

        public static const const_127: int = 1;

        public static const const_188: int = 2;

        public static const const_175: int = 0;

        public static const const_100: int = 1;

        public static const const_196: int = 2;

        public static const const_60: int = 0;

        public static const const_245: int = 1;

        public static const const_288: int = 2;

        public function class_1732(param1: IMessageDataWrapper) {
            super();
            var_1263 = param1.readInteger();
            var_794 = param1.readInteger();
            var_1329 = param1.readInteger();
            var_823 = param1.readInteger();
            var_1117 = param1.readInteger();
        }
        private var var_1263: int = 0;
        private var var_794: int = 1;
        private var var_1329: int = 1;
        private var var_1117: int = 1;
        private var var_823: int = 14;

        public function get mode(): int {
            return var_1263;
        }

        public function get bubbleWidth(): int {
            return var_794;
        }

        public function get scrollSpeed(): int {
            return var_1329;
        }

        public function get fullHearRange(): int {
            return var_823;
        }

        public function get floodSensitivity(): int {
            return var_1117;
        }
    }
}
