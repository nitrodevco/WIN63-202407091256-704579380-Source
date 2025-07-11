package com.sulake.habbo.communication.messages.outgoing.nft {
   import com.sulake.core.communication.messages.IMessageComposer

   public class SaveUserNftWardrobeMessageComposer implements IMessageComposer {

        public function SaveUserNftWardrobeMessageComposer(param1: String) {
            var_20 = [];
            super();
            var_20.push(param1);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
