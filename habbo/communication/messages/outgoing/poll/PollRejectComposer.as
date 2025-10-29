package com.sulake.habbo.communication.messages.outgoing.poll {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PollRejectComposer implements IMessageComposer {

        public function PollRejectComposer(param1: int) {
            super();
            var_47 = [param1];
        }
        private var var_47: Array = null;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
