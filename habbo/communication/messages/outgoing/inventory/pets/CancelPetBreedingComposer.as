package com.sulake.habbo.communication.messages.outgoing.inventory.pets {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class CancelPetBreedingComposer implements IMessageComposer {

        public function CancelPetBreedingComposer(param1: int) {
            var_47 = [];
            super();
            var_47.push(param1);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
