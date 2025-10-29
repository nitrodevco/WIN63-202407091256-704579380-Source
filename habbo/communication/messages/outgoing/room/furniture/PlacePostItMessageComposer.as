package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PlacePostItMessageComposer implements IMessageComposer {

        public function PlacePostItMessageComposer(param1: int, param2: String) {
            super();
            var_517 = param1;
            var_587 = param2;
        }
        private var var_517: int;
        private var var_587: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_517, var_587];
        }
    }
}
