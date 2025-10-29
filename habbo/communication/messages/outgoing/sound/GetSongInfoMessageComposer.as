package com.sulake.habbo.communication.messages.outgoing.sound {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class GetSongInfoMessageComposer implements IMessageComposer, IDisposable {

        public function GetSongInfoMessageComposer(param1: Array) {
            var_20 = [];
            super();
            var_20.push(param1.length);
            for each(var _loc2_ in param1) {
                var_20.push(_loc2_);
            }
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
