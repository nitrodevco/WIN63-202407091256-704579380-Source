package com.sulake.habbo.communication.messages.outgoing.poll {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_163 implements IMessageComposer {

        public function class_163(param1: int, param2: int, param3: Array) {
            var _loc4_: int = 0;
            super();
            var_47 = [param1, param2];
            var_47.push(param3.length);
            _loc4_ = 0;
            while (_loc4_ < param3.length) {
                var_47.push(String(param3[_loc4_]));
                _loc4_++;
            }
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
