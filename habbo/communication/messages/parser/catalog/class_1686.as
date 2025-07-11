package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1686 {

        public function class_1686(param1: IMessageDataWrapper) {
            super();
            var_329 = param1.readInteger();
            var_1204 = param1.readInteger();
            var_907 = param1.readInteger();
            var_988 = param1.readBoolean();
            var_1056 = param1.readBoolean();
        }
        private var var_329: int;
        private var var_1204: int;
        private var var_907: int;
        private var var_988: Boolean;
        private var var_1056: Boolean;

        public function get type(): int {
            return var_329;
        }

        public function get breedId(): int {
            return var_1204;
        }

        public function get paletteId(): int {
            return var_907;
        }

        public function get sellable(): Boolean {
            return var_988;
        }

        public function get rare(): Boolean {
            return var_1056;
        }
    }
}
