package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CantConnectMessageEventParser implements IMessageParser {

        public static const const_111: int = 1;

        public static const const_347: int = 2;

        public static const const_354: int = 3;

        public static const const_260: int = 4;

        public function CantConnectMessageEventParser() {
            super();
        }
        private var var_326: int = 0;
        private var var_215: String = "";

        public function get reason(): int {
            return var_326;
        }

        public function get parameter(): String {
            return var_215;
        }

        public function flush(): Boolean {
            var_326 = 0;
            var_215 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_326 = param1.readInteger();
            if (var_326 == 3) {
                var_215 = param1.readString();
            } else {
                var_215 = "";
            }
            return true;
        }
    }
}
