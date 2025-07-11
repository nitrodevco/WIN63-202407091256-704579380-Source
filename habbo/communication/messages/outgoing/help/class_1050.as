package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_1050 implements IMessageComposer {

        public function class_1050(param1: int) {
            super();
            var_516 = param1;
        }
        private var var_516: int;

        public function getMessageArray(): Array {
            return [var_516];
        }

        public function dispose(): void {
        }
    }
}
