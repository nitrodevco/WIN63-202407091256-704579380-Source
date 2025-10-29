package com.sulake.habbo.communication.messages.outgoing.game.directory {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class Game2LeaveGameMessageComposer implements IMessageComposer {

        public function Game2LeaveGameMessageComposer() {
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
