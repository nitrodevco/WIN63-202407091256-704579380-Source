package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class UpdateGuildBadgeMessageComposer implements IMessageComposer {

        public function UpdateGuildBadgeMessageComposer(param1: int, param2: Array) {
            var _loc3_: int = 0;
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2.length);
            _loc3_ = 0;
            while (_loc3_ < param2.length) {
                var_47.push(int(param2[_loc3_]));
                _loc3_++;
            }
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
