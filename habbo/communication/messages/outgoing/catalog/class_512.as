package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_512 implements IMessageComposer {

        public function class_512(param1: int) {
            var_47 = [];
            super();
            var_47.push(param1);
        }
        private var var_47: Array;

        public function dispose(): void {
            var_47 = [];
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
