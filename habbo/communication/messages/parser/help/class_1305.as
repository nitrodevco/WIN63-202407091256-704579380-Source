package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1305 implements IMessageParser {

        private static const const_377: int = 0;

        private static const const_326: int = 1;

        private static const const_386: int = 2;

        private static const const_192: int = 3;

        public function class_1305() {
            super();
        }
        private var var_152: int = -1;

        public function get localizationCode(): String {
            switch (var_152) {
                case 0:
                    return "sent";
                case 1:
                    return "blocked";
                case 2:
                    return "nochat";
                case 3:
                    return "alreadyreported";
                default:
                    return "invalid";
            }
        }

        public function flush(): Boolean {
            var_152 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_152 = param1.readInteger();
            return true;
        }
    }
}
