package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_1003 implements IMessageComposer {

        public function class_1003(param1: Boolean, param2: int, param3: Boolean) {
            super();
            var_47 = [param1, param2, param3];
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
