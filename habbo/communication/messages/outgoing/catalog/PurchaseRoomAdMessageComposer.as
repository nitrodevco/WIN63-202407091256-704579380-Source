package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PurchaseRoomAdMessageComposer implements IMessageComposer {

        public function PurchaseRoomAdMessageComposer(param1: int, param2: int, param3: int, param4: String, param5: Boolean, param6: String, param7: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
            var_47.push(param4);
            var_47.push(param5);
            var_47.push(param6);
            var_47.push(param7);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
        }
    }
}
