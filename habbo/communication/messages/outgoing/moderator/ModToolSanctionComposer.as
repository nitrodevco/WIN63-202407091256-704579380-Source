package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ModToolSanctionComposer implements IMessageComposer, IDisposable {

        public function ModToolSanctionComposer(param1: int, param2: int, param3: int) {
            var_20 = [];
            super();
            this.var_20.push(param1);
            this.var_20.push(param2);
            this.var_20.push(param3);
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
