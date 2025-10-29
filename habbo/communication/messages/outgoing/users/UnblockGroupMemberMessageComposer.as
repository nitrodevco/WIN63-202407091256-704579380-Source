package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class UnblockGroupMemberMessageComposer implements IMessageComposer {

        public function UnblockGroupMemberMessageComposer(param1: int, param2: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
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
