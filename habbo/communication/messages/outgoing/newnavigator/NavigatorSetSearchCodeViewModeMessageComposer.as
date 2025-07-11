package com.sulake.habbo.communication.messages.outgoing.newnavigator {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class NavigatorSetSearchCodeViewModeMessageComposer implements IMessageComposer {

        public function NavigatorSetSearchCodeViewModeMessageComposer(param1: String, param2: int) {
            var_192 = [];
            super();
            var_192 = [param1, param2];
        }
        private var var_192: Array;

        public function getMessageArray(): Array {
            return var_192;
        }

        public function dispose(): void {
            var_192 = null;
        }
    }
}
