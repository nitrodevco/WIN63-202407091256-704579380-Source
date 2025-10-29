package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.communication.util.Long
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class WiredSetObjectVariableValueMessageComposer implements IMessageComposer, IDisposable {

        public function WiredSetObjectVariableValueMessageComposer(param1: int, param2: int, param3: Long, param4: int) {
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2);
            var_20.push(param3);
            var_20.push(param4);
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
