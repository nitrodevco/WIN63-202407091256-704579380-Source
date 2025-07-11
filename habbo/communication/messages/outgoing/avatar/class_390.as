package com.sulake.habbo.communication.messages.outgoing.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_390 implements IMessageComposer {

        public function class_390(param1: String) {
            super();
            var_47 = [];
            var_47.push(param1);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
