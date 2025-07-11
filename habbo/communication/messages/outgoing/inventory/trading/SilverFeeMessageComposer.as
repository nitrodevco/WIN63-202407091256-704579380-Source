package com.sulake.habbo.communication.messages.outgoing.inventory.trading {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SilverFeeMessageComposer implements IMessageComposer {

        public function SilverFeeMessageComposer(param1: Boolean) {
            var_20 = [];
            super();
            var_20.push(param1);
        }
        private var var_20: Array;

        public function dispose(): void {
            var_20 = null;
        }

        public function getMessageArray(): Array {
            return var_20;
        }
    }
}
