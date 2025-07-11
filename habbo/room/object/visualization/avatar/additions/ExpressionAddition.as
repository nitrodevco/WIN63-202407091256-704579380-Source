package com.sulake.habbo.room.object.visualization.avatar.additions {
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization
    import com.sulake.room.object.visualization.IRoomObjectSprite

    public class ExpressionAddition implements IExpressionAddition {

        public function ExpressionAddition(param1: int, param2: int, param3: AvatarVisualization) {
            super();
            var_329 = param2;
            var_280 = param1;
            var_254 = param3;
        }
        protected var var_280: int;
        protected var var_254: AvatarVisualization;
        private var var_329: int = -1;

        public function get type(): int {
            return var_329;
        }

        public function get id(): int {
            return var_280;
        }

        public function get disposed(): Boolean {
            return var_254 == null;
        }

        public function dispose(): void {
            var_254 = null;
        }

        public function update(param1: IRoomObjectSprite, param2: Number): void {
        }

        public function animate(param1: IRoomObjectSprite): Boolean {
            return false;
        }
    }
}
