package com.sulake.habbo.communication.messages.outgoing.game.arena {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2ExitGameMessageComposer implements IMessageComposer {

        public function Game2ExitGameMessageComposer(param1: Boolean = true) {
            super();
            var_1003 = param1;
        }
        private var var_1003: Boolean;

        public function getMessageArray(): Array {
            return [var_1003];
        }

        public function dispose(): void {
        }
    }
}
