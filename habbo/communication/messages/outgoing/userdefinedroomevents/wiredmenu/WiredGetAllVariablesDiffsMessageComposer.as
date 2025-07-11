package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.communication.util.Long
   import com.sulake.core.runtime.IDisposable

   import flash.utils.Dictionary

   [SecureSWF(rename="true")]
    public class WiredGetAllVariablesDiffsMessageComposer implements IMessageComposer, IDisposable {

        public function WiredGetAllVariablesDiffsMessageComposer(param1: Dictionary) {
            var _loc5_: int = 0;
            var_20 = [];
            super();
            if (param1 == null) {
                var_20.push(0);
                return;
            }
            var _loc2_: int = 0;
            for (var _loc4_ in param1) {
                _loc2_ += 1;
            }
            var_20.push(_loc2_);
            for (var _loc3_ in param1) {
                _loc5_ = int(param1[_loc3_]);
                var_20.push(new Long(_loc3_));
                var_20.push(_loc5_);
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
