package com.sulake.habbo.communication.messages.outgoing.handshake {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_489 implements IMessageComposer {

        public function class_489(param1: int, param2: String, param3: String) {
            super();
            var_1064 = param1;
            var_998 = param2;
            var_924 = param3;
        }
        private var var_1064: int;
        private var var_998: String;
        private var var_924: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_1064, var_998, var_924];
        }
    }
}
