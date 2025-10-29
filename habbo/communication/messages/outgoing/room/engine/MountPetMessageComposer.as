package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class MountPetMessageComposer implements IMessageComposer {

        public function MountPetMessageComposer(param1: int, param2: Boolean) {
            super();
            var_393 = param1;
            var_856 = param2;
        }
        private var var_393: int;
        private var var_856: Boolean;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_393, var_856];
        }
    }
}
