package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_279 implements IMessageComposer {

        public function class_279(param1: String, param2: Array) {
            var _loc3_: int = 0;
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2.length);
            _loc3_ = 0;
            while (_loc3_ < param2.length) {
                var_20.push(param2[_loc3_]);
                _loc3_++;
            }
        }
        private var var_20: Array;

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
