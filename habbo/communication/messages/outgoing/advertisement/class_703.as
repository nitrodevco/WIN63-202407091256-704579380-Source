package com.sulake.habbo.communication.messages.outgoing.advertisement {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_703 implements IMessageComposer {

        public function class_703() {
            var_47 = [];
            super();
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
