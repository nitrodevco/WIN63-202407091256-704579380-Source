package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_1693 {

        public static const const_388: String = "mv";

        public static const const_380: String = "sld";

        public function class_1693(param1: int, param2: Vector3d, param3: Vector3d, param4: String = null) {
            super();
            var_280 = param1;
            var_501 = param2;
            var_294 = param3;
            var_595 = param4;
        }
        private var var_280: int = 0;
        private var var_501: Vector3d;
        private var var_294: Vector3d;
        private var var_595: String;
        private var var_25: Boolean = false;

        public function get id(): int {
            return var_280;
        }

        public function get loc(): Vector3d {
            return var_501;
        }

        public function set loc(param1: Vector3d): void {
            if (!var_25) {
                var_501 = param1;
            }
        }

        public function get target(): Vector3d {
            return var_294;
        }

        public function set target(param1: Vector3d): void {
            if (!var_25) {
                var_294 = param1;
            }
        }

        public function get moveType(): String {
            return var_595;
        }

        public function set moveType(param1: String): void {
            if (!var_25) {
                var_595 = param1;
            }
        }

        public function setReadOnly(): void {
            var_25 = true;
        }
    }
}
