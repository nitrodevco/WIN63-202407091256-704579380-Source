package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PurchaseBasicMembershipExtensionComposer implements IMessageComposer {

        public function PurchaseBasicMembershipExtensionComposer(param1: int) {
            var_47 = [];
            super();
            var_47.push(param1);
        }
        private var var_47: Array;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
