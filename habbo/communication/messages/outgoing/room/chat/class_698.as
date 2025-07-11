package com.sulake.habbo.communication.messages.outgoing.room.chat {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_698 implements IMessageComposer {

        public function class_698(param1: String, param2: int = 0, param3: int = -1) {
            super();
            _text = param1;
            var_950 = param2;
            var_1291 = param3;
        }
        private var _text: String;
        private var var_1291: int = 0;
        private var var_950: int = 0;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [_text, var_950, var_1291];
        }
    }
}
