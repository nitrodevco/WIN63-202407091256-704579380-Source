package com.sulake.habbo.communication.messages.outgoing.game.directory {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2GetAccountGameStatusMessageComposer implements IMessageComposer {

        public function Game2GetAccountGameStatusMessageComposer(param1: int) {
            var_47 = [];
            super();
            var_47.push(param1);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
        }
    }
}
