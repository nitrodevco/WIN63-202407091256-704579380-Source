package com.sulake.habbo.communication.messages.outgoing.friendlist {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class SendRoomInviteMessageComposer implements IMessageComposer, IDisposable {

        public function SendRoomInviteMessageComposer(param1: String) {
            var_196 = [];
            super();
            this._msg = param1;
        }
        private var var_196: Array;
        private var _msg: String;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            var _loc2_: int = 0;
            var _loc1_: Array = [];
            _loc1_.push(this.var_196.length);
            _loc2_ = 0;
            while (_loc2_ < this.var_196.length) {
                _loc1_.push(this.var_196[_loc2_]);
                _loc2_++;
            }
            _loc1_.push(this._msg);
            return _loc1_;
        }

        public function addInvitedFriend(param1: int): void {
            this.var_196.push(param1);
        }

        public function dispose(): void {
            this.var_196 = null;
        }
    }
}
