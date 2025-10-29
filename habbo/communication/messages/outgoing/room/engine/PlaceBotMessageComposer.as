package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PlaceBotMessageComposer implements IMessageComposer {

        public function PlaceBotMessageComposer(param1: int, param2: int, param3: int) {
            super();
            var_536 = param1;
            var_31 = param2;
            var_28 = param3;
        }
        private var var_536: int;
        private var var_31: int;
        private var var_28: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_536, var_31, var_28];
        }
    }
}
