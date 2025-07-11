package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_508 implements IMessageComposer {

        public function class_508(param1: int, param2: String, param3: String = "") {
            super();
            var_455 = param1;
            var_129 = param2;
            var_1408 = param3;
        }
        private var var_455: int;
        private var var_129: String;
        private var var_1408: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455, var_129, var_1408];
        }
    }
}
