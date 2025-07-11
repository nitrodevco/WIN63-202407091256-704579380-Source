package com.sulake.habbo.communication.messages.outgoing.tracking {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class LatencyPingReportMessageComposer implements IMessageComposer {

        public function LatencyPingReportMessageComposer(param1: int, param2: int, param3: int) {
            super();
            var_971 = param1;
            var_792 = param2;
            var_1238 = param3;
        }
        private var var_971: int;
        private var var_792: int;
        private var var_1238: int;

        public function getMessageArray(): Array {
            return [var_971, var_792, var_1238];
        }

        public function dispose(): void {
        }
    }
}
