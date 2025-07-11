package com.sulake.habbo.communication.messages.outgoing.room.action {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_999 implements IMessageComposer {

        public function class_999(param1: int, param2: int) {
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2);
        }
        private var var_20: Array;

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
