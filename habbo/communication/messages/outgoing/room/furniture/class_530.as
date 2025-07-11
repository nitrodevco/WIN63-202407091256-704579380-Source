package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_530 implements IMessageComposer {

        public function class_530(param1: int, param2: String, param3: String, param4: String) {
            super();
            var_517 = param1;
            var_587 = param2;
            var_368 = param4;
            var_821 = param3;
        }
        private var var_517: int;
        private var var_587: String;
        private var var_368: String;
        private var var_821: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_517, var_587, var_821, var_368];
        }
    }
}
