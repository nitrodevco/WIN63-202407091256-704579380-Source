package com.sulake.habbo.communication.messages.outgoing.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SaveWardrobeOutfitMessageComposer implements IMessageComposer {

        public function SaveWardrobeOutfitMessageComposer(param1: int, param2: String, param3: String) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
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
