package com.sulake.habbo.communication.messages.outgoing.room.session {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_325 implements IMessageComposer {

        public function class_325() {
            super();
        }

        public function get disposed(): Boolean {
            return true;
        }

        public function getMessageArray(): Array {
            return [];
        }

        public function dispose(): void {
        }
    }
}
