package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.visualization.utils.IGraphicAsset

    import flash.geom.Vector3D

    public class FurnitureParticleSystemParticle {

        public function FurnitureParticleSystemParticle() {
            super();
        }
        private var var_31: Number;
        private var var_28: Number;
        private var var_30: Number;
        private var var_2783: Number;
        private var var_2982: Number;
        private var var_2810: Number;
        private var var_2285: Boolean = false;
        private var var_1210: Vector3D;
        private var var_1427: int = 0;
        private var _lifeTime: int;
        private var var_3432: Boolean = false;
        private var var_3096: Boolean = false;
        private var _fadeTime: Number;
        private var var_2792: Number = 1;
        private var var_1862: Array;

        public function get fade(): Boolean {
            return var_3096;
        }

        public function get alphaMultiplier(): Number {
            return var_2792;
        }

        public function get direction(): Vector3D {
            return var_1210;
        }

        public function get age(): int {
            return var_1427;
        }

        public function get isEmitter(): Boolean {
            return var_3432;
        }

        public function get isAlive(): Boolean {
            return var_1427 <= _lifeTime;
        }

        public function get x(): Number {
            return var_31;
        }

        public function set x(param1: Number): void {
            var_31 = param1;
        }

        public function get y(): Number {
            return var_28;
        }

        public function set y(param1: Number): void {
            var_28 = param1;
        }

        public function get z(): Number {
            return var_30;
        }

        public function set z(param1: Number): void {
            var_30 = param1;
        }

        public function get lastX(): Number {
            return var_2783;
        }

        public function set lastX(param1: Number): void {
            var_2285 = true;
            var_2783 = param1;
        }

        public function get lastY(): Number {
            return var_2982;
        }

        public function set lastY(param1: Number): void {
            var_2285 = true;
            var_2982 = param1;
        }

        public function get lastZ(): Number {
            return var_2810;
        }

        public function set lastZ(param1: Number): void {
            var_2285 = true;
            var_2810 = param1;
        }

        public function get hasMoved(): Boolean {
            return var_2285;
        }

        public function init(param1: Number, param2: Number, param3: Number, param4: Vector3D, param5: Number, param6: Number, param7: int, param8: Boolean = false, param9: Array = null, param10: Boolean = false): void {
            var_31 = param1;
            var_28 = param2;
            var_30 = param3;
            var_1210 = new Vector3D(param4.x, param4.y, param4.z);
            var_1210.scaleBy(param5);
            var_2783 = var_31 - var_1210.x * param6;
            var_2982 = var_28 - var_1210.y * param6;
            var_2810 = var_30 - var_1210.z * param6;
            var_1427 = 0;
            var_2285 = false;
            _lifeTime = param7;
            var_3432 = param8;
            var_1862 = param9;
            var_3096 = param10;
            var_2792 = 1;
            _fadeTime = 0.5 + Math.random() * 0.5;
        }

        public function update(): void {
            var_1427++;
            if (var_1427 == _lifeTime) {
                ignite();
            }
            if (var_3096) {
                if (var_1427 / _lifeTime > _fadeTime) {
                    var_2792 = (_lifeTime - var_1427) / (_lifeTime * (1 - _fadeTime));
                }
            }
        }

        public function getAsset(): IGraphicAsset {
            if (var_1862 && var_1862.length > 0) {
                return var_1862[var_1427 % var_1862.length];
            }
            return null;
        }

        public function dispose(): void {
            var_1210 = null;
        }

        public function toString(): String {
            return [var_31, var_28, var_30].toString();
        }

        public function copy(param1: FurnitureParticleSystemParticle, param2: Number): void {
            var_31 = param1.var_31 * param2;
            var_28 = param1.var_28 * param2;
            var_30 = param1.var_30 * param2;
            var_2783 = param1.var_2783 * param2;
            var_2982 = param1.var_2982 * param2;
            var_2810 = param1.var_2810 * param2;
            var_2285 = param1.hasMoved;
            var_1210 = param1.var_1210;
            var_1427 = param1.var_1427;
            _lifeTime = param1._lifeTime;
            var_3432 = param1.var_3432;
            var_3096 = param1.var_3096;
            _fadeTime = param1._fadeTime;
            var_2792 = param1.var_2792;
        }

        protected function ignite(): void {
        }
    }
}
