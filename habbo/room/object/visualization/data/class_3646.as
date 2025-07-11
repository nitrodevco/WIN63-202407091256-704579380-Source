package com.sulake.habbo.room.object.visualization.data {
    public class class_3646 {

        public static const DEFAULT_TAG: String = "";

        public static const DEFAULT_INK: int = 0;

        public static const DEFAULT_ALPHA: int = 255;

        public static const DEFAULT_IGNORE_MOUSE: Boolean = false;

        public static const DEFAULT_X_OFFSET: int = 0;

        public static const DEFAULT_Y_OFFSET: int = 0;

        public static const DEFAULT_Z_OFFSET: int = 0;

        public static const INK_ADD: int = 1;

        public static const INK_SUBTRACT: int = 2;

        public static const INK_DARKEN: int = 3;

        public static const INK_DIFFERENCE: int = 4;

        public static const INK_MULTIPLY: int = 5;

        public static const INK_INVERT: int = 6;

        public static const INK_SCREEN: int = 7;

        public function class_3646() {
            super();
        }
        private var var_881: String = "";
        private var var_4150: int = 0;

        private var _alpha: int = 255;

        public function get alpha(): int {
            return _alpha;
        }

        public function set alpha(param1: int): void {
            _alpha = param1;
        }

        private var _ignoreMouse: Boolean = false;

        public function get ignoreMouse(): Boolean {
            return _ignoreMouse;
        }

        public function set ignoreMouse(param1: Boolean): void {
            _ignoreMouse = param1;
        }

        private var _xOffset: int = 0;

        public function get xOffset(): int {
            return _xOffset;
        }

        public function set xOffset(param1: int): void {
            _xOffset = param1;
        }

        private var _yOffset: int = 0;

        public function get yOffset(): int {
            return _yOffset;
        }

        public function set yOffset(param1: int): void {
            _yOffset = param1;
        }

        private var _zOffset: Number = 0;

        public function get zOffset(): Number {
            return _zOffset;
        }

        public function set zOffset(param1: Number): void {
            _zOffset = param1;
        }

        public function get tag(): String {
            return var_881;
        }

        public function set tag(param1: String): void {
            var_881 = param1;
        }

        public function get ink(): int {
            return var_4150;
        }

        public function set ink(param1: int): void {
            var_4150 = param1;
        }

        public function copyValues(param1: class_3646): void {
            if (param1 != null) {
                tag = param1.tag;
                ink = param1.ink;
                alpha = param1.alpha;
                ignoreMouse = param1.ignoreMouse;
                xOffset = param1.xOffset;
                yOffset = param1.yOffset;
                zOffset = param1.zOffset;
            }
        }
    }
}
