package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   public class ClickFurniMessageComposer implements IMessageComposer {

        public function ClickFurniMessageComposer(param1: int, param2: int = 0) {
            super();
            var_455 = param1;
            var_329 = param2;
        }
        private var var_455: int;
        private var var_329: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455, var_329];
        }
    }
}
