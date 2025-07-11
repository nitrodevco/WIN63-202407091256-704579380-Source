package com.sulake.habbo.room.object.visualization.data {
    import flash.utils.Dictionary

    public class class_3534 {

        public function class_3534() {
            _offsetX = new Dictionary();
            _offsetY = new Dictionary();
            super();
        }
        private var _offsetX: Dictionary;
        private var _offsetY: Dictionary;

        public function getOffsetX(param1: int, param2: int): int {
            if (_offsetX[param1] == null) {
                return param2;
            }
            return _offsetX[param1];
        }

        public function getOffsetY(param1: int, param2: int): int {
            if (_offsetY[param1] == null) {
                return param2;
            }
            return _offsetY[param1];
        }

        public function setOffset(param1: int, param2: int, param3: int): void {
            _offsetX[param1] = param2;
            _offsetY[param1] = param3;
        }
    }
}
