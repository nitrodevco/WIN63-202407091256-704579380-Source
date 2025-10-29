package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class DiceOffMessageComposer implements IMessageComposer {

        public function DiceOffMessageComposer(param1: int) {
            super();
            var_455 = param1;
        }
        private var var_455: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455];
        }
    }
}
