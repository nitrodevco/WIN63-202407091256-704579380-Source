package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_704 implements IMessageComposer {

        public function class_704(param1: int, param2: int = 0) {
            super();
            var_455 = param1;
            var_837 = param2;
        }
        private var var_455: int;
        private var var_837: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455, var_837];
        }
    }
}
