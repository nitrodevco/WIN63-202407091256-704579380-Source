package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class KickMemberMessageComposer implements IMessageComposer {

        public function KickMemberMessageComposer(param1: int, param2: int, param3: Boolean = false) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
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
