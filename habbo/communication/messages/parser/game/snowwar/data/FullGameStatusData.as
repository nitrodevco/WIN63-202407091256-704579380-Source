package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class FullGameStatusData {

        public function FullGameStatusData(param1: IMessageDataWrapper) {
            super();
            parse(param1);
        }
        private var var_1298: int;
        private var var_1337: int;
        private var var_757: GameObjectsData;
        private var var_1201: GameStatusData;

        private var _numberOfTeams: int;

        public function get numberOfTeams(): int {
            return _numberOfTeams;
        }

        public function get remainingTimeSeconds(): int {
            return var_1298;
        }

        public function get durationInSeconds(): int {
            return var_1337;
        }

        public function get gameObjects(): GameObjectsData {
            return var_757;
        }

        public function get gameStatus(): GameStatusData {
            return var_1201;
        }

        public function parse(param1: IMessageDataWrapper): void {
            param1.readInteger();
            var_1298 = param1.readInteger();
            var_1337 = param1.readInteger();
            var_757 = new GameObjectsData(param1);
            param1.readInteger();
            _numberOfTeams = param1.readInteger();
            var_1201 = new GameStatusData(param1);
        }
    }
}
