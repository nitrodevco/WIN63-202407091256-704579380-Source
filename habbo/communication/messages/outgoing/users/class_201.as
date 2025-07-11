package com.sulake.habbo.communication.messages.outgoing.users {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_201 implements IMessageComposer {

        public function class_201(param1: int, param2: Boolean) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
        }
        private var var_47: Array;

        public function dispose(): void {
            var_47 = null;
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
