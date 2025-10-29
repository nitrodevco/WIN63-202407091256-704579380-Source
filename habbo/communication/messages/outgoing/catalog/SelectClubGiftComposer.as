package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SelectClubGiftComposer implements IMessageComposer {

        public function SelectClubGiftComposer(param1: String) {
            super();
            var_394 = param1;
        }
        private var var_394: String;

        public function getMessageArray(): Array {
            return [var_394];
        }

        public function dispose(): void {
            var_394 = null;
        }
    }
}
