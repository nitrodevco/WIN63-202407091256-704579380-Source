package com.sulake.habbo.communication.messages.outgoing.room.session {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class ChangeQueueMessageComposer implements IMessageComposer {

        public function ChangeQueueMessageComposer(param1: int) {
            super();
            var_1195 = param1;
        }
        private var var_1195: int;

        public function get disposed(): Boolean {
            return true;
        }

        public function getMessageArray(): Array {
            return [var_1195];
        }

        public function dispose(): void {
        }
    }
}
