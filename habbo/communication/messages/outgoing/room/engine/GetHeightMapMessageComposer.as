package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetHeightMapMessageComposer implements IMessageComposer {

        public function GetHeightMapMessageComposer() {
            super();
        }

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [];
        }
    }
}
