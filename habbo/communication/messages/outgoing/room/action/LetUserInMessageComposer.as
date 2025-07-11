package com.sulake.habbo.communication.messages.outgoing.room.action {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class LetUserInMessageComposer implements IMessageComposer {

        public function LetUserInMessageComposer(param1: String, param2: Boolean) {
            super();
            var_368 = [param1, param2];
        }
        private var var_368: Array;

        public function dispose(): void {
            var_368 = null;
        }

        public function getMessageArray(): Array {
            return var_368;
        }
    }
}
