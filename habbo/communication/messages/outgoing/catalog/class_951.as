package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_951 implements IMessageComposer {

        public function class_951(param1: int) {
            super();
            var_1340 = param1;
        }
        private var var_1340: int;

        public function getMessageArray(): Array {
            return [var_1340];
        }

        public function dispose(): void {
        }
    }
}
