package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetCatalogPageComposer implements IMessageComposer {

        public function GetCatalogPageComposer(param1: int, param2: int, param3: String) {
            super();
            var_47 = [param1, param2, param3];
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
