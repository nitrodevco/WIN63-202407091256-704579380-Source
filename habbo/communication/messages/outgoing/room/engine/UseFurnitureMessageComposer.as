package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class UseFurnitureMessageComposer implements IMessageComposer {

        public function UseFurnitureMessageComposer(param1: int, param2: int = 0) {
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
