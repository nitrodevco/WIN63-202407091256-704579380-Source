package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetCatalogIndexComposer implements IMessageComposer {

        public function GetCatalogIndexComposer(param1: String) {
            super();
            var_47 = [param1];
        }
        private var var_47: Array;

        public function dispose(): void {
            var_47 = null;
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
