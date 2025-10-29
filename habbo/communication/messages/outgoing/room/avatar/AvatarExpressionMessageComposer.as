package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class AvatarExpressionMessageComposer implements IMessageComposer {

        public function AvatarExpressionMessageComposer(param1: int) {
            super();
            var_553 = param1;
        }
        private var var_553: int = 0;

        public function dispose(): void {
            var_553 = 0;
        }

        public function getMessageArray(): Array {
            return [var_553];
        }
    }
}
