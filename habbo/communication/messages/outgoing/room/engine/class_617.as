package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_617 implements IMessageComposer {

        public function class_617(param1: int, param2: int, param3: int, param4: int) {
            super();
            var_455 = param1;
            var_31 = param2;
            var_28 = param3;
            var_1210 = param4;
        }
        private var var_455: int;
        private var var_31: int;
        private var var_28: int;
        private var var_1210: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455, var_31, var_28, var_1210];
        }
    }
}
