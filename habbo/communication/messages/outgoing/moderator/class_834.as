package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class class_834 implements IMessageComposer, IDisposable {

        public function class_834(param1: int, param2: Array, param3: int) {
            var _loc4_: int = 0;
            var_20 = [];
            super();
            this.var_20.push(param1);
            this.var_20.push(param2.length);
            _loc4_ = 0;
            while (_loc4_ < param2.length) {
                this.var_20.push(param2[_loc4_]);
                _loc4_++;
            }
            this.var_20.push(param3);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
