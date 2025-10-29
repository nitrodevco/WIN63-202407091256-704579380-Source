package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PlacePetMessageComposer implements IMessageComposer {

        public function PlacePetMessageComposer(param1: int, param2: int, param3: int) {
            super();
            var_393 = param1;
            var_31 = param2;
            var_28 = param3;
        }
        private var var_393: int;
        private var var_31: int;
        private var var_28: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_393, var_31, var_28];
        }
    }
}
