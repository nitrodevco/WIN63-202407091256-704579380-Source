package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetYoutubeDisplayStatusMessageComposer implements IMessageComposer {

        public function GetYoutubeDisplayStatusMessageComposer(param1: int) {
            super();
            var_20 = [param1];
        }
        private var var_20: Array;

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
