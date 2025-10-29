package com.sulake.habbo.communication.messages.outgoing.tracking {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class PerformanceLogMessageComposer implements IMessageComposer {

        public function PerformanceLogMessageComposer(param1: int, userAgent: String, param3: String, param4: String, param5: String, param6: Boolean, param7: int, param8: int, param9: int, param10: int, param11: int) {
            super();
            var_20 = [param1, userAgent, param3, param4, param5, param6, param7, param8, param9, param10, param11];
        }
        private var var_20: Array;

        public function dispose(): void {
            var_20 = null;
        }

        public function getMessageArray(): Array {
            return var_20;
        }
    }
}
