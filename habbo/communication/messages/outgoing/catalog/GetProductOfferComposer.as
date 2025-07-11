package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetProductOfferComposer implements IMessageComposer {

        public function GetProductOfferComposer(param1: int) {
            super();
            _offerId = param1;
        }
        private var _offerId: int;

        public function getMessageArray(): Array {
            return [_offerId];
        }

        public function dispose(): void {
        }
    }
}
