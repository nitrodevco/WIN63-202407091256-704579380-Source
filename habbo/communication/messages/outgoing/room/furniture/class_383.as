package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_383 implements IMessageComposer {

        public function class_383(param1: int, param2: String) {
            super();
            var_455 = param1;
            var_970 = param2;
        }
        private var var_455: int;
        private var var_970: String;

        public function getMessageArray(): Array {
            return [var_455, var_970];
        }

        public function dispose(): void {
        }
    }
}
