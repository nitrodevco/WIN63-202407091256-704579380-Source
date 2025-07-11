package com.sulake.habbo.communication.messages.outgoing.hotlooks {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.communication.util.Byte

   [SecureSWF(rename="true")]
    public class class_632 implements IMessageComposer {

        public function class_632(param1: int) {
            var_20 = [];
            super();
            var_20.push(new Byte(param1));
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
