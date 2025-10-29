package com.sulake.habbo.communication.messages.outgoing.groupforums {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class GetForumStatsMessageComposer implements IMessageComposer, IDisposable {

        public function GetForumStatsMessageComposer(param1: int) {
            var_20 = [];
            super();
            this.var_20 = [param1];
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
