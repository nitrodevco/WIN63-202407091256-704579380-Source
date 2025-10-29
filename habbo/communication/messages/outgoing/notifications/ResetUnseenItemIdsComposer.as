package com.sulake.habbo.communication.messages.outgoing.notifications {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ResetUnseenItemIdsComposer implements IMessageComposer, IDisposable {

        public function ResetUnseenItemIdsComposer(param1: int, param2: Array) {
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2.length);
            var_20 = var_20.concat(param2);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
