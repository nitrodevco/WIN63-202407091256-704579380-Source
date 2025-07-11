package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_825 implements IMessageComposer {

        public function class_825(param1: int, param2: int, param3: int, param4: int) {
            super();
            var_603 = param1;
            var_1235 = param2;
            var_1010 = param3;
            var_1227 = param4;
        }
        private var var_603: int;
        private var var_1235: int;
        private var var_1010: int;
        private var var_1227: int;

        public function getMessageArray(): Array {
            return [var_603, var_1235, var_1010, var_1227];
        }

        public function dispose(): void {
        }
    }
}
