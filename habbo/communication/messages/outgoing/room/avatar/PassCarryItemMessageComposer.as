package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PassCarryItemMessageComposer implements IMessageComposer {

        public function PassCarryItemMessageComposer(param1: int) {
            super();
            var_418 = param1;
        }
        private var var_418: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_418];
        }
    }
}
