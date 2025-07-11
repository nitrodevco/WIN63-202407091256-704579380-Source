package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class ChangePostureMessageComposer implements IMessageComposer {

        public function ChangePostureMessageComposer(param1: int) {
            super();
            var_917 = param1;
        }
        private var var_917: int;

        public function getMessageArray(): Array {
            return [var_917];
        }

        public function dispose(): void {
        }
    }
}
