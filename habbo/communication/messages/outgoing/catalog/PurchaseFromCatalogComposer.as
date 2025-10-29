package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PurchaseFromCatalogComposer implements IMessageComposer {

        public function PurchaseFromCatalogComposer(param1: int, param2: int, param3: String, param4: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
            var_47.push(param4);
        }
        private var var_47: Array;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
