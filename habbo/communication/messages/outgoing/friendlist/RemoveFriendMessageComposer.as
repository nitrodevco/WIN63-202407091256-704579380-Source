package com.sulake.habbo.communication.messages.outgoing.friendlist {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class RemoveFriendMessageComposer implements IMessageComposer, IDisposable {

        public function RemoveFriendMessageComposer() {
            var_207 = [];
            super();
        }
        private var var_207: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            var _loc2_: int = 0;
            var _loc1_: Array = [];
            _loc1_.push(this.var_207.length);
            _loc2_ = 0;
            while (_loc2_ < this.var_207.length) {
                _loc1_.push(this.var_207[_loc2_]);
                _loc2_++;
            }
            return _loc1_;
        }

        public function addRemovedFriend(param1: int): void {
            this.var_207.push(param1);
        }

        public function dispose(): void {
            this.var_207 = null;
        }
    }
}
