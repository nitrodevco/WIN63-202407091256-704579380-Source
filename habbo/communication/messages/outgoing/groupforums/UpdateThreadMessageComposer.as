package com.sulake.habbo.communication.messages.outgoing.groupforums {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class UpdateThreadMessageComposer implements IMessageComposer, IDisposable {

        public function UpdateThreadMessageComposer(param1: int, param2: int, param3: Boolean, param4: Boolean) {
            var_20 = [];
            super();
            this.var_20 = [param1, param2, param4, param3];
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

        public function unwatch(param1: String): void {
            super.unwatch(param1);
        }
    }
}
