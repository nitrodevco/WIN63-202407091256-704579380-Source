package com.sulake.habbo.room.utils {
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_3355 {

        private static const MOVE_SPEED_DENOMINATOR: Number = 12;

        public function class_3355() {
            var_3997 = new Vector3d();
            super();
        }
        private var var_1458: int = -1;
        private var var_4270: int = -2;
        private var var_1822: Vector3d = null;
        private var var_3142: Number = 0;
        private var var_3447: Number = 0;
        private var var_3629: Boolean = false;
        private var var_1781: Vector3d = null;
        private var var_3997: Vector3d;
        private var var_4269: Boolean = false;
        private var var_4347: Boolean = false;
        private var var_4628: Boolean = false;
        private var var_4329: Boolean = false;
        private var var_4470: int = 0;
        private var var_4582: int = 0;
        private var var_911: int = 0;
        private var var_4809: int = 0;
        private var var_4277: int = 0;
        private var var_3848: int = -1;
        private var var_3807: Boolean = false;
        private var var_4534: int;

        public function get location(): IVector3d {
            return var_1781;
        }

        public function get targetId(): int {
            return var_1458;
        }

        public function set targetId(param1: int): void {
            var_1458 = param1;
        }

        public function get targetCategory(): int {
            return var_4270;
        }

        public function set targetCategory(param1: int): void {
            var_4270 = param1;
        }

        public function get targetObjectLoc(): IVector3d {
            return var_3997;
        }

        public function set targetObjectLoc(param1: IVector3d): void {
            var_3997.assign(param1);
        }

        public function get limitedLocationX(): Boolean {
            return var_4269;
        }

        public function set limitedLocationX(param1: Boolean): void {
            var_4269 = param1;
        }

        public function get limitedLocationY(): Boolean {
            return var_4347;
        }

        public function set limitedLocationY(param1: Boolean): void {
            var_4347 = param1;
        }

        public function get centeredLocX(): Boolean {
            return var_4628;
        }

        public function set centeredLocX(param1: Boolean): void {
            var_4628 = param1;
        }

        public function get centeredLocY(): Boolean {
            return var_4329;
        }

        public function set centeredLocY(param1: Boolean): void {
            var_4329 = param1;
        }

        public function get screenWd(): int {
            return var_4470;
        }

        public function set screenWd(param1: int): void {
            var_4470 = param1;
        }

        public function get screenHt(): int {
            return var_4582;
        }

        public function set screenHt(param1: int): void {
            var_4582 = param1;
        }

        public function get scale(): int {
            return var_911;
        }

        public function set scale(param1: int): void {
            if (var_911 != param1) {
                var_911 = param1;
                var_3807 = true;
            }
        }

        public function get roomWd(): int {
            return var_4809;
        }

        public function set roomWd(param1: int): void {
            var_4809 = param1;
        }

        public function get roomHt(): int {
            return var_4277;
        }

        public function set roomHt(param1: int): void {
            var_4277 = param1;
        }

        public function get geometryUpdateId(): int {
            return var_3848;
        }

        public function set geometryUpdateId(param1: int): void {
            var_3848 = param1;
        }

        public function get isMoving(): Boolean {
            if (var_1822 != null && var_1781 != null) {
                return true;
            }
            return false;
        }

        public function set target(param1: IVector3d): void {
            var _loc2_: Vector3d = null;
            if (var_1822 == null) {
                var_1822 = new Vector3d();
            }
            if (var_1822.x != param1.x || var_1822.y != param1.y || var_1822.z != param1.z) {
                var_1822.assign(param1);
                _loc2_ = Vector3d.dif(var_1822, var_1781);
                var_3142 = _loc2_.length;
                var_3629 = true;
            }
        }

        public function dispose(): void {
            var_1822 = null;
            var_1781 = null;
        }

        public function initializeLocation(param1: IVector3d): void {
            if (var_1781 != null) {
                return;
            }
            var_1781 = new Vector3d();
            var_1781.assign(param1);
        }

        public function resetLocation(param1: IVector3d): void {
            if (var_1781 == null) {
                var_1781 = new Vector3d();
            }
            var_1781.assign(param1);
        }

        public function update(param1: uint, param2: Number): void {
            var _loc4_: Vector3d = null;
            var _loc5_: Number = NaN;
            var _loc6_: Number = NaN;
            var _loc3_: Number = NaN;
            var _loc7_: Number = NaN;
            if (var_4534 > 0 && var_1822 != null && var_1781 != null) {
                if (var_3807) {
                    var_3807 = false;
                    var_1781 = var_1822;
                    var_1822 = null;
                    return;
                }
                if ((_loc4_ = Vector3d.dif(var_1822, var_1781)).length > var_3142) {
                    var_3142 = _loc4_.length;
                }
                if (_loc4_.length <= param2) {
                    var_1781 = var_1822;
                    var_1822 = null;
                    var_3447 = 0;
                } else {
                    _loc5_ = Math.sin(3.141592653589793 * _loc4_.length / var_3142);
                    _loc6_ = param2 * 0.5;
                    _loc3_ = var_3142 / 12;
                    _loc7_ = _loc6_ + (_loc3_ - _loc6_) * _loc5_;
                    if (var_3629) {
                        if (_loc7_ < var_3447) {
                            if ((_loc7_ = var_3447) > _loc4_.length) {
                                _loc7_ = _loc4_.length;
                            }
                        } else {
                            var_3629 = false;
                        }
                    }
                    var_3447 = _loc7_;
                    _loc4_.div(_loc4_.length);
                    _loc4_.mul(_loc7_);
                    var_1781 = Vector3d.sum(var_1781, _loc4_);
                }
            }
        }

        public function reset(): void {
            var_3848 = -1;
        }

        public function activateFollowing(param1: int): void {
            var_4534 = param1;
        }
    }
}
