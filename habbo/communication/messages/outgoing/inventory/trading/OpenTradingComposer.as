package com.sulake.habbo.communication.messages.outgoing.inventory.trading {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class OpenTradingComposer implements IMessageComposer {

        public function OpenTradingComposer(param1: int) {
            super();
            var_785 = param1;
        }
        private var var_785: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_785];
        }
    }
}
