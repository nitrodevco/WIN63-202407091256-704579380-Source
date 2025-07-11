package com.sulake.habbo.room.utils {
    [SecureSWF(rename="true")]
    public class class_1769 {

        public function class_1769(param1: int, param2: XML) {
            super();
            var_369 = param1;
            var_47 = param2;
        }
        private var var_369: int;
        private var var_47: XML;
        private var var_551: String = null;
        private var var_444: String = null;
        private var var_370: String = null;

        public function get roomId(): int {
            return var_369;
        }

        public function get data(): XML {
            return var_47;
        }

        public function get floorType(): String {
            return var_551;
        }

        public function set floorType(param1: String): void {
            var_551 = param1;
        }

        public function get wallType(): String {
            return var_444;
        }

        public function set wallType(param1: String): void {
            var_444 = param1;
        }

        public function get landscapeType(): String {
            return var_370;
        }

        public function set landscapeType(param1: String): void {
            var_370 = param1;
        }
    }
}
