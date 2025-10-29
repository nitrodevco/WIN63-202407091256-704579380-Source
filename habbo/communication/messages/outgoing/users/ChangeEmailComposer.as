package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class ChangeEmailComposer implements IMessageComposer {

        public function ChangeEmailComposer(param1: String) {
            super();
            var_1486 = param1;
        }
        private var var_1486: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_1486];
        }
    }
}
