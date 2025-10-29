package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class OpenMysteryTrophyMessageComposer implements IMessageComposer {

        public function OpenMysteryTrophyMessageComposer(param1: int, param2: String) {
            super();
            var_455 = param1;
            var_1170 = param2;
        }
        private var var_455: int;
        private var var_1170: String;

        public function getMessageArray(): Array {
            return [var_455, var_1170];
        }

        public function dispose(): void {
        }
    }
}
