package com.sulake.habbo.communication.messages.outgoing.poll {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_753 implements IMessageComposer {

        public function class_753(param1: int) {
            super();
            var_47 = [param1];
        }
        private var var_47: Array = null;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
