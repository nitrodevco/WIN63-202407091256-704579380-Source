package com.sulake.habbo.communication.messages.outgoing.moderator {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class CloseIssuesMessageComposer implements IMessageComposer, IDisposable {

        public function CloseIssuesMessageComposer(param1: Array, param2: int) {
            var _loc3_: int = 0;
            var_20 = [];
            super();
            this.var_20.push(param2);
            this.var_20.push(param1.length);
            _loc3_ = 0;
            while (_loc3_ < param1.length) {
                this.var_20.push(param1[_loc3_]);
                _loc3_++;
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
