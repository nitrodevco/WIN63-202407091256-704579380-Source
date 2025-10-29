package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class CallForHelpFromIMMessageComposer implements IMessageComposer, IDisposable {

        public function CallForHelpFromIMMessageComposer(param1: String, param2: int, param3: int, param4: Array) {
            var_20 = [];
            super();
            this.var_20.push(param1);
            this.var_20.push(param2);
            this.var_20.push(param3);
            this.var_20.push(param4.length / 2);
            this.var_20 = this.var_20.concat(param4);
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
