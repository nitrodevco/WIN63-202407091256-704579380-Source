package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1735 {

        public function class_1735(param1: IMessageDataWrapper) {
            super();
            var_1070 = param1.readInteger();
            var_753 = param1.readString();
            var_848 = param1.readBoolean();
            var_984 = param1.readBoolean();
            var_942 = param1.readString();
            var_624 = param1.readString();
            var_1367 = param1.readBoolean();
        }
        private var var_1070: int;
        private var var_753: String;
        private var var_848: Boolean;
        private var var_984: Boolean;
        private var var_942: String;
        private var var_624: String;
        private var var_1367: Boolean;

        public function get nodeId(): int {
            return var_1070;
        }

        public function get nodeName(): String {
            return var_753;
        }

        public function get visible(): Boolean {
            return var_848;
        }

        public function get automatic(): Boolean {
            return var_984;
        }

        public function get staffOnly(): Boolean {
            return var_1367;
        }

        public function get automaticCategoryKey(): String {
            return var_942;
        }

        public function get globalCategoryKey(): String {
            return var_624;
        }

        public function get visibleName(): String {
            return var_624 == "" ? var_753 : "${navigator.flatcategory.global." + var_624 + "}";
        }
    }
}
