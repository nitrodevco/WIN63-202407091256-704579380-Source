package com.sulake.habbo.communication.messages.outgoing.navigator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ConvertGlobalRoomIdMessageComposer implements IMessageComposer, IDisposable {

        public function ConvertGlobalRoomIdMessageComposer(param1: String) {
            super();
            this.flatId = param1;
        }
        private var flatId: String;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return [flatId];
        }

        public function dispose(): void {
        }
    }
}
