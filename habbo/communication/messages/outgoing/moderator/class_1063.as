package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class class_1063 implements IMessageComposer, IDisposable {

        public function class_1063(param1: Array, param2: Boolean, param3: int, param4: String) {
            var _loc5_: int = 0;
            var_20 = [];
            super();
            this.var_20.push(param1.length);
            _loc5_ = 0;
            while (_loc5_ < param1.length) {
                this.var_20.push(param1[_loc5_]);
                _loc5_++;
            }
            this.var_20.push(param2);
            this.var_20.push(param3);
            this.var_20.push(param4);
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
