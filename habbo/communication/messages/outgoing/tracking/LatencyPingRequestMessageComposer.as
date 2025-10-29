package com.sulake.habbo.communication.messages.outgoing.tracking {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class LatencyPingRequestMessageComposer implements IMessageComposer {

        public function LatencyPingRequestMessageComposer(param1: int) {
            super();
            var_280 = param1;
        }
        private var var_280: int = 0;

        public function getMessageArray(): Array {
            return [var_280];
        }

        public function dispose(): void {
        }
    }
}
