package com.sulake.habbo.communication.messages.outgoing.newnavigator {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class NavigatorRemoveCollapsedCategoryMessageComposer implements IMessageComposer {

        public function NavigatorRemoveCollapsedCategoryMessageComposer(param1: String) {
            var_192 = [];
            super();
            var_192.push(param1);
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
