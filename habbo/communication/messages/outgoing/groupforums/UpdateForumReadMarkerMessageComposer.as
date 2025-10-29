package com.sulake.habbo.communication.messages.outgoing.groupforums {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class UpdateForumReadMarkerMessageComposer implements IMessageComposer, IDisposable {

        public function UpdateForumReadMarkerMessageComposer() {
            var_20 = [0];
            super();
        }
        private var var_20: Array;

        public function get size(): int {
            return var_20[0];
        }

        public function get disposed(): Boolean {
            return false;
        }

        public function add(param1: int, param2: int, param3: Boolean): void {
            var_20.push(param1, param2, param3);
            var_20[0]++;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
