package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SignMessageComposer implements IMessageComposer {

        public function SignMessageComposer(param1: int) {
            super();
            var_1059 = param1;
        }
        private var var_1059: int;

        public function getMessageArray(): Array {
            return [var_1059];
        }

        public function dispose(): void {
        }
    }
}
