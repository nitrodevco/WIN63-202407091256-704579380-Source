package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1718 {

        public static const PRODUCT_TYPE_ITEM: String = "i";

        public static const PRODUCT_TYPE_STUFF: String = "s";

        public static const PRODUCT_TYPE_EFFECT: String = "e";

        public static const PRODUCT_TYPE_BADGE: String = "b";

        public static const const_316: String = "cl";

        public function class_1718(param1: IMessageDataWrapper) {
            super();
            var_398 = param1.readString();
            var _loc2_: String = var_398;
            if ("b" !== _loc2_) {
                var_817 = param1.readInteger();
                var_586 = param1.readString();
                var_519 = param1.readInteger();
                var_686 = param1.readBoolean();
                if (var_686) {
                    var_1488 = param1.readInteger();
                    var_1157 = param1.readInteger();
                }
            } else {
                var_586 = param1.readString();
                var_519 = 1;
            }
        }
        private var var_398: String;
        private var var_817: int;
        private var var_586: String;
        private var var_519: int;
        private var var_686: Boolean;
        private var var_1488: int;
        private var var_1157: int;

        public function get productType(): String {
            return var_398;
        }

        public function get furniClassId(): int {
            return var_817;
        }

        public function get extraParam(): String {
            return var_586;
        }

        public function get productCount(): int {
            return var_519;
        }

        public function get uniqueLimitedItem(): Boolean {
            return var_686;
        }

        public function get uniqueLimitedItemSeriesSize(): int {
            return var_1488;
        }

        public function get uniqueLimitedItemsLeft(): int {
            return var_1157;
        }
    }
}
