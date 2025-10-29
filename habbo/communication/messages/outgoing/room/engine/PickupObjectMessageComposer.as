package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PickupObjectMessageComposer implements IMessageComposer {

        public function PickupObjectMessageComposer(param1: int, param2: int, param3: Boolean = false) {
            super();
            var_455 = param1;
            var_1114 = param2;
            var_805 = param3;
        }
        private var var_455: int;
        private var var_1114: int;
        private var var_805: Boolean;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            var _loc1_: int = 0;
            switch (var_1114 - 10) {
                case 0:
                    _loc1_ = 2;
                    break;
                case 10:
                    _loc1_ = 1;
                    break;
                default:
                    return [];
            }
            return [_loc1_, var_455, var_805];
        }
    }
}
