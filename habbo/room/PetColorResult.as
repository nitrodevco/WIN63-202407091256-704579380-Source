package com.sulake.habbo.room {
    public class PetColorResult {

        private static const COLOR_TAGS: Array = ["Null", "Black", "White", "Grey", "Red", "Orange", "Pink", "Green", "Lime", "Blue", "Light-Blue", "Dark-Blue", "Yellow", "Brown", "Dark-Brown", "Beige", "Cyan", "Purple", "Gold"];

        public function PetColorResult(param1: int, param2: int, param3: int, param4: int, param5: String, param6: Boolean, param7: Array) {
            var_3693 = [];
            super();
            _primaryColor = param1 & 16777215;
            _secondaryColor = param2 & 16777215;
            var_4504 = param3;
            var_881 = param4 > -1 && param4 < COLOR_TAGS.length ? COLOR_TAGS[param4] : "";
            var_280 = param5;
            var_4840 = param6;
            var_3693 = param7;
        }
        private var var_4504: int;
        private var var_881: String;
        private var var_280: String;
        private var var_4840: Boolean = false;
        private var var_3693: Array;

        private var _primaryColor: int = 0;

        public function get primaryColor(): int {
            return _primaryColor;
        }

        private var _secondaryColor: int = 0;

        public function get secondaryColor(): int {
            return _secondaryColor;
        }

        public function get breed(): int {
            return var_4504;
        }

        public function get tag(): String {
            return var_881;
        }

        public function get id(): String {
            return var_280;
        }

        public function get isMaster(): Boolean {
            return var_4840;
        }

        public function get layerTags(): Array {
            return var_3693;
        }
    }
}
