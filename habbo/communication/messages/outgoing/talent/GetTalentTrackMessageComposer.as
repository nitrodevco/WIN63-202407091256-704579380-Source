package com.sulake.habbo.communication.messages.outgoing.talent {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class GetTalentTrackMessageComposer implements IMessageComposer, IDisposable {

        public function GetTalentTrackMessageComposer(param1: String) {
            var_47 = [];
            super();
            var_47.push(param1);
        }
        private var var_47: Array;

        public function get disposed(): Boolean {
            return var_47 == null;
        }

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
