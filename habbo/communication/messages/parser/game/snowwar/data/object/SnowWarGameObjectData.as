package com.sulake.habbo.communication.messages.parser.game.snowwar.data.object {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class SnowWarGameObjectData {

        public static const const_140: int = 1;

        public static const const_276: int = 2;

        public static const const_345: int = 3;

        public static const const_59: int = 4;

        public static const const_248: int = 5;

        public static function create(param1: int, param2: int): SnowWarGameObjectData {
            switch (param1 - 1) {
                case 0:
                    return new SnowballGameObjectData(param1, param2);
                case 1:
                    return new TreeGameObjectData(param1, param2);
                case 2:
                    return new SnowballPileGameObjectData(param1, param2);
                case 3:
                    return new SnowballMachineGameObjectData(param1, param2);
                case 4:
                    return new HumanGameObjectData(param1, param2);
                default:
                    return null;
            }
        }

        public function SnowWarGameObjectData(param1: int, param2: int) {
            var_353 = [];
            super();
            setVariable(0, param1);
            setVariable(1, param2);
        }
        protected var var_353: Array;

        public function get type(): int {
            return getVariable(0);
        }

        public function get id(): int {
            return getVariable(1);
        }

        public function getVariable(param1: int): int {
            return var_353[param1];
        }

        public function parse(param1: IMessageDataWrapper): void {
        }

        protected function setVariable(param1: int, param2: int): void {
            var_353[param1] = param2;
        }

        protected function parseVariables(param1: IMessageDataWrapper, param2: int): void {
            var _loc3_: int = 0;
            _loc3_ = 2;
            while (_loc3_ < param2) {
                var_353.push(param1.readInteger());
                _loc3_++;
            }
        }
    }
}
