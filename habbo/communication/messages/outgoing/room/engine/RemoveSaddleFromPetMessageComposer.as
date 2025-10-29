package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class RemoveSaddleFromPetMessageComposer implements IMessageComposer {

        public function RemoveSaddleFromPetMessageComposer(param1: int) {
            super();
            var_393 = param1;
        }
        private var var_393: int;

        public function getMessageArray(): Array {
            return [var_393];
        }

        public function dispose(): void {
        }
    }
}
