package com.sulake.habbo.communication.messages.outgoing.handshake {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_3383 implements IMessageComposer {

        public function class_3383(param1: String, param2: String, param3: int) {
            super();
            _username = param1;
            var_937 = param2;
            var_418 = param3;
        }
        private var _username: String;
        private var var_937: String;
        private var var_418: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [];
        }
    }
}
