package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_230 implements IMessageComposer {

        public function class_230(param1: int) {
            super();
            var_455 = param1;
        }
        private var var_455: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455];
        }
    }
}
