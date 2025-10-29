package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetGuildFurniContextMenuInfoMessageComposer implements IMessageComposer {

        public function GetGuildFurniContextMenuInfoMessageComposer(param1: int, param2: int) {
            super();
            var_455 = param1;
            var_364 = param2;
        }
        private var var_455: int;
        private var var_364: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455, var_364];
        }
    }
}
