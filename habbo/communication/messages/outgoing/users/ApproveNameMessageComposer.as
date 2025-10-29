package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class ApproveNameMessageComposer implements IMessageComposer {

        public function ApproveNameMessageComposer(param1: String, param2: int) {
            super();
            _name = param1;
            var_329 = param2;
        }
        private var _name: String;
        private var var_329: int;

        public function getMessageArray(): Array {
            return [_name, var_329];
        }

        public function dispose(): void {
        }
    }
}
