package com.sulake.habbo.communication.messages.outgoing.preferences {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class SetSoundSettingsComposer implements IMessageComposer, IDisposable {

        public function SetSoundSettingsComposer(param1: int, param2: int, param3: int) {
            var_20 = [];
            super();
            var_20.push(param3);
            var_20.push(param2);
            var_20.push(param1);
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
