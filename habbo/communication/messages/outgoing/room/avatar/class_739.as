package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_739 implements IMessageComposer {

        public function class_739(param1: String) {
            super();
            var_962 = param1;
        }
        private var var_962: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_962];
        }
    }
}
