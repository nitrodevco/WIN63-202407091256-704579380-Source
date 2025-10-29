package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class ScrGetUserInfoMessageComposer implements IMessageComposer, IDisposable {

        public function ScrGetUserInfoMessageComposer(param1: String) {
            var_20 = [];
            super();
            this.var_20.push(param1);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
