package com.sulake.habbo.communication.messages.outgoing.quest {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class StartCampaignMessageComposer implements IMessageComposer {

        public function StartCampaignMessageComposer(param1: String) {
            var_47 = [];
            super();
            var_47.push(param1);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
