package com.sulake.habbo.communication.messages.outgoing.room.action {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class MuteUserMessageComposer implements IMessageComposer {

        public function MuteUserMessageComposer(param1: int, param2: int, param3: int = 0) {
            super();
            var_418 = param1;
            var_369 = param3;
            var_1352 = param2;
        }
        private var var_418: int;
        private var var_369: int = 0;
        private var var_1352: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_418, var_369, var_1352];
        }
    }
}
