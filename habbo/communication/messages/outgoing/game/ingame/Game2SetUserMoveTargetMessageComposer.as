package com.sulake.habbo.communication.messages.outgoing.game.ingame {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2SetUserMoveTargetMessageComposer implements IMessageComposer {

        public function Game2SetUserMoveTargetMessageComposer(param1: int, param2: int, param3: int, param4: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
            var_47.push(param4);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = [];
        }
    }
}
