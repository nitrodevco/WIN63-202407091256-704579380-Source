package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1391 implements IMessageParser {

        public static var var_1593: int = 0;

        public static var var_1605: int = 1;

        public function class_1391() {
            super();
        }
        private var var_553: int;
        private var var_562: int;
        private var var_586: String;

        private var var_31: int;

        private var var_28: int;

        private var var_1210: int;

        private var var_1126: String;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get typeCode(): int {
            return var_553;
        }

        public function get pageId(): int {
            return var_562;
        }

        public function get extraParam(): String {
            return var_586;
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        public function get direction(): int {
            return var_1210;
        }

        public function get wallLocation(): String {
            return var_1126;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_553 = param1.readInteger();
            var_562 = param1.readInteger();
            _offerId = param1.readInteger();
            var_586 = param1.readString();
            if (var_553 == var_1593) {
                var_31 = param1.readInteger();
                var_28 = param1.readInteger();
                var_1210 = param1.readInteger();
            } else {
                var_1126 = param1.readString();
            }
            return true;
        }
    }
}
