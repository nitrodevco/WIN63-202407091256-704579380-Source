package com.sulake.habbo.communication.messages.outgoing.preferences {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class class_435 implements IMessageComposer, IDisposable {

        public function class_435(param1: int, param2: int, param3: int, param4: int, param5: Boolean, param6: int) {
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2);
            var_20.push(param3);
            var_20.push(param4);
            var_20.push(param5);
            var_20.push(param6);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return var_20 == null;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
