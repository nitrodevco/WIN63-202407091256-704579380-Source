package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_571 implements IMessageComposer {

        public function class_571(param1: int) {
            super();
            var_455 = param1;
        }
        private var var_455: int;

        public function getMessageArray(): Array {
            return [var_455];
        }

        public function dispose(): void {
        }
    }
}
