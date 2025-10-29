package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class ExtendRentOrBuyoutStripItemMessageComposer implements IMessageComposer {

        public function ExtendRentOrBuyoutStripItemMessageComposer(param1: int, param2: Boolean) {
            super();
            var_47 = [param1, param2];
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
