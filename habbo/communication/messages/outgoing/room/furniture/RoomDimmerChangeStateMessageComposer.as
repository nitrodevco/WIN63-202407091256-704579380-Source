package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class RoomDimmerChangeStateMessageComposer implements IMessageComposer {

        public function RoomDimmerChangeStateMessageComposer(param1: int) {
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
