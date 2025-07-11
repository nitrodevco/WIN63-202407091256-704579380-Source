package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_303 implements IMessageComposer {

        public function class_303(param1: int) {
            super();
            var_634 = param1;
        }
        private var var_634: int;

        public function getMessageArray(): Array {
            return [var_634];
        }

        public function dispose(): void {
        }
    }
}
