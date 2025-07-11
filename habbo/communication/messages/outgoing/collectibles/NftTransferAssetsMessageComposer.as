package com.sulake.habbo.communication.messages.outgoing.collectibles {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class NftTransferAssetsMessageComposer implements IMessageComposer {

        public function NftTransferAssetsMessageComposer(param1: String) {
            var_20 = [];
            super();
            var_20.push(param1);
        }
        private var var_20: Array;

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = [];
        }
    }
}
