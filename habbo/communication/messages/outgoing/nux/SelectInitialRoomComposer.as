package com.sulake.habbo.communication.messages.outgoing.nux {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SelectInitialRoomComposer implements IMessageComposer {

        public function SelectInitialRoomComposer(param1: String) {
            super();
            var_47 = [];
            var_47.push(param1);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
