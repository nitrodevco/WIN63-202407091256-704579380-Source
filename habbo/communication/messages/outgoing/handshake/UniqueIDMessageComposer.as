package com.sulake.habbo.communication.messages.outgoing.handshake {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class UniqueIDMessageComposer implements IMessageComposer {

        public function UniqueIDMessageComposer(param1: String, param2: String, param3: String) {
            super();
            var_233 = param1;
            var_1391 = param2;
            var_1356 = param3;
        }
        private var var_233: String;
        private var var_1391: String;
        private var var_1356: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_233, var_1391, var_1356];
        }
    }
}
