package com.sulake.habbo.communication.messages.outgoing.inventory.trading {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_822 implements IMessageComposer {

        public function class_822(param1: int) {
            super();
            var_922 = param1;
        }
        private var var_922: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_922];
        }
    }
}
