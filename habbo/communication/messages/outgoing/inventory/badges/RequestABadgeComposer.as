package com.sulake.habbo.communication.messages.outgoing.inventory.badges {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class RequestABadgeComposer implements IMessageComposer {

        public function RequestABadgeComposer(param1: String) {
            super();
            var_804 = param1;
        }
        private var var_804: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            var _loc1_: Array = [];
            _loc1_.push(var_804);
            return _loc1_;
        }
    }
}
