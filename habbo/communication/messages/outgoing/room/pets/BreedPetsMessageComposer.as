package com.sulake.habbo.communication.messages.outgoing.room.pets {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class BreedPetsMessageComposer implements IMessageComposer {

        public static const const_357: int = 0;

        public static const const_12: int = 1;

        public static const const_11: int = 2;

        public function BreedPetsMessageComposer(param1: int, param2: int, param3: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
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
