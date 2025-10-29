package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class ReleaseIssuesMessageComposer implements IMessageComposer, IDisposable {

        public function ReleaseIssuesMessageComposer(param1: Array) {
            var _loc2_: int = 0;
            var_20 = [];
            super();
            this.var_20.push(param1.length);
            _loc2_ = 0;
            while (_loc2_ < param1.length) {
                this.var_20.push(param1[_loc2_]);
                _loc2_++;
            }
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
