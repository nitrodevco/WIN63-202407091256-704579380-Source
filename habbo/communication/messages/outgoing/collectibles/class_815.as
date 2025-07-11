package com.sulake.habbo.communication.messages.outgoing.collectibles {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_815 implements IMessageComposer {

        public function class_815() {
            var_20 = [];
            super();
        }
        private var var_20: Array;

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = [];
        }
    }
}
