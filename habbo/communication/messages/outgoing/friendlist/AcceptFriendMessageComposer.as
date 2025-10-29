package com.sulake.habbo.communication.messages.outgoing.friendlist {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class AcceptFriendMessageComposer implements IMessageComposer, IDisposable {

        public function AcceptFriendMessageComposer() {
            var_202 = [];
            super();
        }
        private var var_202: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            var _loc2_: int = 0;
            var _loc1_: Array = [];
            _loc1_.push(this.var_202.length);
            _loc2_ = 0;
            while (_loc2_ < this.var_202.length) {
                _loc1_.push(this.var_202[_loc2_]);
                _loc2_++;
            }
            return _loc1_;
        }

        public function addAcceptedRequest(param1: int): void {
            this.var_202.push(param1);
        }

        public function dispose(): void {
            this.var_202 = null;
        }
    }
}
