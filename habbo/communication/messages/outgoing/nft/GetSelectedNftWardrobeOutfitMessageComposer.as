package com.sulake.habbo.communication.messages.outgoing.nft {
   import com.sulake.core.communication.messages.IMessageComposer

   public class GetSelectedNftWardrobeOutfitMessageComposer implements IMessageComposer {

        public function GetSelectedNftWardrobeOutfitMessageComposer() {
            var_20 = [];
            super();
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function GetUserNftWardrobeMessageComposer(): * {
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
