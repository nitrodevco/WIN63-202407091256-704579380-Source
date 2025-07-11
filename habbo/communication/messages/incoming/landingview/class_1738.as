package com.sulake.habbo.communication.messages.incoming.landingview {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1738 {

        public static const const_323: int = 0;

        public static const const_256: int = 1;

        public static const const_21: int = 2;

        public function class_1738(param1: IMessageDataWrapper) {
            super();
            var_280 = param1.readInteger();
            var_617 = param1.readString();
            var_1268 = param1.readString();
            var_1290 = param1.readString();
            var_882 = param1.readInteger();
            var_1453 = param1.readString();
            var_406 = param1.readString();
        }
        private var var_280: int;
        private var var_617: String;
        private var var_1268: String;
        private var var_1290: String;
        private var var_882: int;
        private var var_1453: String;
        private var var_406: String;

        public function get id(): int {
            return var_280;
        }

        public function get title(): String {
            return var_617;
        }

        public function get bodyText(): String {
            return var_1268;
        }

        public function get buttonText(): String {
            return var_1290;
        }

        public function get linkType(): int {
            return var_882;
        }

        public function get linkContent(): String {
            return var_1453;
        }

        public function get imageUrl(): String {
            return var_406;
        }
    }
}
