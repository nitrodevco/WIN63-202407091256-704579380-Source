package com.sulake.habbo.communication.messages.outgoing.room.chat {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_847 implements IMessageComposer {

        public function class_847(param1: String, param2: String, param3: int = 0) {
            super();
            _recipientName = param1;
            _text = param2;
            var_950 = param3;
        }
        private var _text: String;
        private var _recipientName: String;
        private var var_950: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [_recipientName + " " + _text, var_950];
        }
    }
}
