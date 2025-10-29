package com.sulake.habbo.communication.messages.outgoing.nux {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class NewUserExperienceScriptProceedComposer implements IMessageComposer, IDisposable {

        public function NewUserExperienceScriptProceedComposer() {
            var_20 = [];
            super();
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
