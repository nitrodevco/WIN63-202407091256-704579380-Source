package com.sulake.habbo.communication.messages.outgoing.inventory.furni {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_984 implements IMessageComposer {

        public function class_984(param1: int) {
            super();
            var_1495 = param1;
        }
        private var var_1495: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            var _loc1_: Array = [];
            _loc1_.push(var_1495);
            return _loc1_;
        }
    }
}
