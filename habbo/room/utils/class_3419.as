package com.sulake.habbo.room.utils {
    [SecureSWF(rename="true")]
    public class class_3419 {

        public function class_3419(param1: int, param2: int) {
            super();
            _width = param1;
            var_46 = param2;
            var_142 = new Vector.<Number>(param1 * param2);
            var_3461 = new Vector.<Boolean>(param1 * param2);
            var_3153 = new Vector.<Boolean>(param1 * param2);
        }
        private var var_142: Vector.<Number>;
        private var var_3461: Vector.<Boolean>;
        private var var_3153: Vector.<Boolean>;
        private var var_46: int = 0;

        private var _width: int = 0;

        public function get width(): int {
            return _width;
        }

        public function get height(): int {
            return var_46;
        }

        public function dispose(): void {
            var_142 = null;
            var_3461 = null;
            var_3153 = null;
            _width = 0;
            var_46 = 0;
        }

        public function getTileHeight(param1: int, param2: int): Number {
            return validPosition(param1, param2) ? var_142[param2 * _width + param1] : 0;
        }

        public function setTileHeight(param1: int, param2: int, param3: Number): void {
            if (validPosition(param1, param2)) {
                var_142[param2 * _width + param1] = param3;
            }
        }

        public function setStackingBlocked(param1: int, param2: int, param3: Boolean): void {
            if (validPosition(param1, param2)) {
                var_3461[param2 * _width + param1] = param3;
            }
        }

        public function setIsRoomTile(param1: int, param2: int, param3: Boolean): void {
            if (validPosition(param1, param2)) {
                var_3153[param2 * _width + param1] = param3;
            }
        }

        public function validateLocation(param1: int, param2: int, param3: int, param4: int, param5: int, param6: int, param7: int, param8: int, param9: Boolean, param10: Number = -1): Boolean {
            var _loc13_: * = 0;
            var _loc11_: * = 0;
            var _loc12_: int = 0;
            if (!validPosition(param1, param2) || !validPosition(param1 + param3 - 1, param2 + param4 - 1)) {
                return false;
            }
            if (param5 < 0 || param5 >= _width) {
                param5 = 0;
            }
            if (param6 < 0 || param6 >= var_46) {
                param6 = 0;
            }
            param7 = Math.min(param7, _width - param5);
            param8 = Math.min(param8, var_46 - param6);
            if (param10 == -1) {
                param10 = getTileHeight(param1, param2);
            }
            _loc13_ = param2;
            while (_loc13_ < param2 + param4) {
                _loc11_ = param1;
                while (_loc11_ < param1 + param3) {
                    if (_loc11_ < param5 || _loc11_ >= param5 + param7 || _loc13_ < param6 || _loc13_ >= param6 + param8) {
                        _loc12_ = _loc13_ * _width + _loc11_;
                        if (param9) {
                            if (!var_3153[_loc12_]) {
                                return false;
                            }
                        } else if (var_3461[_loc12_] || !var_3153[_loc12_] || Math.abs(var_142[_loc12_] - param10) > 0.01) {
                            return false;
                        }
                    }
                    _loc11_++;
                }
                _loc13_++;
            }
            return true;
        }

        private function validPosition(param1: int, param2: int): Boolean {
            return param1 >= 0 && param1 < _width && param2 >= 0 && param2 < var_46;
        }
    }
}
