package com.sulake.habbo.communication.messages.outgoing.room.avatar {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_724 implements IMessageComposer {

        public function class_724(param1: int) {
            super();
            _style = param1;
        }
        private var _style: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [_style];
        }
    }
}
