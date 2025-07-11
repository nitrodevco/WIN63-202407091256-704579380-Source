package com.sulake.habbo.communication.messages.outgoing.game.arena {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2GameChatMessageComposer implements IMessageComposer {

        public function Game2GameChatMessageComposer(param1: String) {
            super();
            var_645 = param1;
        }
        private var var_645: String;

        public function getMessageArray(): Array {
            return [var_645];
        }

        public function dispose(): void {
            var_645 = null;
        }
    }
}
