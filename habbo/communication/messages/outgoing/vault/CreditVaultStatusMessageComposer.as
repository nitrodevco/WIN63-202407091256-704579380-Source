package com.sulake.habbo.communication.messages.outgoing.vault {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class CreditVaultStatusMessageComposer implements IMessageComposer, IDisposable {

        public function CreditVaultStatusMessageComposer() {
            var_20 = [];
            super();
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
