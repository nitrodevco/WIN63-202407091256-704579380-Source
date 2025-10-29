package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class GetGuildCreationInfoMessageComposer implements IMessageComposer {

        public function GetGuildCreationInfoMessageComposer() {
            var_47 = [];
            super();
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
