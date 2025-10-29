package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ModTradingLockMessageComposer implements IMessageComposer, IDisposable {

        public static const const_5: int = -1;

        public function ModTradingLockMessageComposer(param1: int, param2: String, param3: int, param4: int, param5: int) {
            var_20 = [];
            super();
            this.var_20.push(param1);
            this.var_20.push(param2);
            this.var_20.push(param3);
            this.var_20.push(param4);
            if (param5 != -1) {
                this.var_20.push(param5);
            }
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
