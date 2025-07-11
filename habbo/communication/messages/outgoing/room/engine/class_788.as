package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_788 implements IMessageComposer {

        public function class_788(param1: int, param2: int, param3: String) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param3);
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
