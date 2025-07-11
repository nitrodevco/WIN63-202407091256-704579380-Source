package com.sulake.habbo.communication.messages.outgoing.friendlist {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class class_170 implements IMessageComposer, IDisposable {

        public function class_170() {
            var_186 = [];
            super();
        }
        private var var_186: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            var _loc2_: int = 0;
            var _loc1_: Array = [];
            if (this.var_186.length == 0) {
                _loc1_.push(true);
                _loc1_.push(0);
            } else {
                _loc1_.push(false);
                _loc1_.push(this.var_186.length);
                _loc2_ = 0;
                while (_loc2_ < this.var_186.length) {
                    _loc1_.push(this.var_186[_loc2_]);
                    _loc2_++;
                }
            }
            return _loc1_;
        }

        public function addDeclinedRequest(param1: int): void {
            this.var_186.push(param1);
        }

        public function dispose(): void {
            this.var_186 = null;
        }
    }
}
