package com.sulake.habbo.communication.messages.outgoing.friendlist {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class SetRelationshipStatusMessageComposer implements IMessageComposer {

        public function SetRelationshipStatusMessageComposer(param1: int, param2: int) {
            super();
            var_1358 = param1;
            var_1499 = param2;
        }

        private var var_1358: int;
        private var var_1499: int;

        public function getMessageArray(): Array {
            return [var_1358, var_1499];
        }

        public function dispose(): void {
        }
    }
}
