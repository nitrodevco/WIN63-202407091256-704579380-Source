package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_218 implements IMessageComposer {

        public function class_218(param1: int, param2: int) {
            super();
            var_31 = param1;
            var_28 = param2;
        }
        private var var_31: int;
        private var var_28: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_31, var_28];
        }
    }
}
