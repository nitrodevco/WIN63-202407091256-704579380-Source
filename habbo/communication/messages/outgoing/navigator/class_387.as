package com.sulake.habbo.communication.messages.outgoing.navigator {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_387 implements IMessageComposer {

        public function class_387(param1: String) {
            super();
            var_329 = param1;
        }
        private var var_329: String;

        public function getMessageArray(): Array {
            return [var_329];
        }

        public function dispose(): void {
            var_329 = null;
        }
    }
}
