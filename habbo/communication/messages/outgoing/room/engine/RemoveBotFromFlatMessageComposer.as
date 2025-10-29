package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class RemoveBotFromFlatMessageComposer implements IMessageComposer {

        public function RemoveBotFromFlatMessageComposer(param1: int) {
            super();
            var_536 = param1;
        }
        private var var_536: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_536];
        }
    }
}
