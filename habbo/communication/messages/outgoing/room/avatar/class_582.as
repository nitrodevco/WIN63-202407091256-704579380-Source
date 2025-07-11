package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_582 implements IMessageComposer {

        public function class_582(param1: int) {
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
