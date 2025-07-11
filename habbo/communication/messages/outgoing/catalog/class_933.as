package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_933 implements IMessageComposer {

        public function class_933(param1: int, param2: int, param3: String, param4: String, param5: String, param6: int, param7: int, param8: int, param9: Boolean) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
            var_47.push(param4);
            var_47.push(param5);
            var_47.push(param6);
            var_47.push(param7);
            var_47.push(param8);
            var_47.push(param9);
        }
        private var var_47: Array;

        public function dispose(): void {
            var_47 = [];
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
