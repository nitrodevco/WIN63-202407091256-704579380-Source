package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SetCustomStackingHeightComposer implements IMessageComposer {

        public function SetCustomStackingHeightComposer(param1: int, param2: int = -100) {
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
