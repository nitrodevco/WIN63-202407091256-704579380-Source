package com.sulake.habbo.communication.messages.incoming.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1723 {

        public static const const_251: int = 0;

        public function class_1723(param1: IMessageDataWrapper) {
            super();
            var_435 = param1.readInteger();
            var_360 = param1.readInteger();
            var_372 = param1.readString();
            var_432 = param1.readInteger();
            var_149 = param1.readInteger();
        }
        private var var_435: int;
        private var var_360: int;
        private var var_372: String;
        private var var_432: int;
        private var var_149: int;

        public function get achievementId(): int {
            return var_435;
        }

        public function get level(): int {
            return var_360;
        }

        public function get badgeId(): String {
            return var_372;
        }

        public function get requiredLevel(): int {
            return var_432;
        }

        public function get enabled(): Boolean {
            return var_149 == 0;
        }

        public function get state(): int {
            return var_149;
        }

        public function dispose(): void {
            var_435 = 0;
            var_360 = 0;
            var_372 = "";
            var_432 = 0;
        }
    }
}
