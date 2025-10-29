package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class WiredGetRoomStatsMessageComposer implements IMessageComposer, IDisposable {

        public function WiredGetRoomStatsMessageComposer() {
            super();
        }

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return [];
        }

        public function dispose(): void {
        }
    }
}
