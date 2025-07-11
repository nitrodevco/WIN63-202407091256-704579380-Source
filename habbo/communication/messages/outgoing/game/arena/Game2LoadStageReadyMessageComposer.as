package com.sulake.habbo.communication.messages.outgoing.game.arena {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2LoadStageReadyMessageComposer implements IMessageComposer {

        public function Game2LoadStageReadyMessageComposer(param1: int) {
            var_47 = [];
            super();
            var_47.push(param1);
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
