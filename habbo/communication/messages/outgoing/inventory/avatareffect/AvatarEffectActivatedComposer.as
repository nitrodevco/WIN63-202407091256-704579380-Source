package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class AvatarEffectActivatedComposer implements IMessageComposer {

        public function AvatarEffectActivatedComposer(param1: int) {
            super();
            var_329 = param1;
        }
        private var var_329: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            var _loc1_: Array = [];
            _loc1_.push(var_329);
            return _loc1_;
        }
    }
}
