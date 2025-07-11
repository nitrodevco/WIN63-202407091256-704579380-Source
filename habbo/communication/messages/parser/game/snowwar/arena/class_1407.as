package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameObjectsData

    [SecureSWF(rename="true")]
    public class class_1407 implements IMessageParser {

        public function class_1407() {
            super();
        }
        private var var_757: GameObjectsData;
        private var var_414: int;
        private var var_485: String;
        private var var_1321: int;

        public function get gameObjects(): GameObjectsData {
            return var_757;
        }

        public function get gameType(): int {
            return var_414;
        }

        public function get roomType(): String {
            return var_485;
        }

        public function get countDown(): int {
            return var_1321;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_414 = param1.readInteger();
            var_485 = param1.readString();
            var_1321 = param1.readInteger();
            var_757 = new GameObjectsData(param1);
            return true;
        }
    }
}
