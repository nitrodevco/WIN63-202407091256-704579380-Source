package com.sulake.habbo.communication.messages.outgoing.tracking {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_448 implements IMessageComposer {

        public function class_448(param1: int) {
            super();
            var_280 = param1;
        }
        private var var_280: int = 0;

        public function getMessageArray(): Array {
            return [var_280];
        }

        public function dispose(): void {
        }
    }
}
