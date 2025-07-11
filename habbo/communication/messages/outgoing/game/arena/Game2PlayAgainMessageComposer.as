package com.sulake.habbo.communication.messages.outgoing.game.arena {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2PlayAgainMessageComposer implements IMessageComposer {

        public function Game2PlayAgainMessageComposer() {
            var_47 = [];
            super();
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
