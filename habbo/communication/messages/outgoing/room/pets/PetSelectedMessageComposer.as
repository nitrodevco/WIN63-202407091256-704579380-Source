package com.sulake.habbo.communication.messages.outgoing.room.pets {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PetSelectedMessageComposer implements IMessageComposer {

        public function PetSelectedMessageComposer(param1: int) {
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
