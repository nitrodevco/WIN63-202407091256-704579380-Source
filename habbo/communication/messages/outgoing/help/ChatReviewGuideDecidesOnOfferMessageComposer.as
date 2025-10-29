package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ChatReviewGuideDecidesOnOfferMessageComposer implements IMessageComposer, IDisposable {

        public function ChatReviewGuideDecidesOnOfferMessageComposer(param1: Boolean) {
            var_20 = [];
            super();
            var_20 = [param1];
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return var_20 == null;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
