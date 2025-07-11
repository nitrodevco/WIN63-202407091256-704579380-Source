package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class WiredSetPreferencesMessageComposer implements IMessageComposer, IDisposable {

        public function WiredSetPreferencesMessageComposer(param1: Boolean, param2: Boolean, param3: Boolean, param4: int) {
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
