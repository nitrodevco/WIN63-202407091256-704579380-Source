package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_656 implements IMessageComposer {

        public function class_656(param1: int, param2: int) {
            super();
            var_1074 = param1;
            var_869 = param2;
        }
        private var var_1074: int;
        private var var_869: int;

        public function getMessageArray(): Array {
            return [var_1074, var_869];
        }

        public function dispose(): void {
        }
    }
}
