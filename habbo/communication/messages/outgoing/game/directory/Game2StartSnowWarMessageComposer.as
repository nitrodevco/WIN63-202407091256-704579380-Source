package com.sulake.habbo.communication.messages.outgoing.game.directory {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class Game2StartSnowWarMessageComposer implements IMessageComposer {

        public function Game2StartSnowWarMessageComposer(param1: String) {
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
