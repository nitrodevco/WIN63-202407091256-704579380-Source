package com.sulake.habbo.communication.messages.outgoing.catalog {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_852 implements IMessageComposer {

        public function class_852(param1: int, param2: int, param3: String, param4: String, param5: Boolean = false) {
            var_47 = [];
            super();
            var_47 = [param1, param2, param3, param4, param5];
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
