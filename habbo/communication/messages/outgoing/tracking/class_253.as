package com.sulake.habbo.communication.messages.outgoing.tracking {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_253 implements IMessageComposer {

        public function class_253(param1: int) {
            super();
            var_1073 = param1;
        }
        private var var_1073: int;

        public function getMessageArray(): Array {
            return [var_1073];
        }

        public function dispose(): void {
        }
    }
}
