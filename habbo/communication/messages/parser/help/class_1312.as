package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.help.data.class_1698

    [SecureSWF(rename="true")]
    public class class_1312 implements IMessageParser {

        public static const const_407: int = 0;

        public static const const_237: int = 1;

        public static const const_392: int = 2;

        public static const const_161: int = 3;

        public function class_1312() {
            super();
        }
        private var var_619: int;
        private var var_374: class_1698;

        public function get statusCode(): int {
            return var_619;
        }

        public function get pendingTicket(): class_1698 {
            return var_374;
        }

        public function get localizationCode(): String {
            switch (var_619 - 2) {
                case 0:
                    return "blocked";
                case 1:
                    return "tooquick";
                default:
                    return "";
            }
        }

        public function flush(): Boolean {
            var_374 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_619 = param1.readInteger();
            if (var_619 == 1) {
                var_374 = new class_1698(param1);
            }
            return true;
        }
    }
}
