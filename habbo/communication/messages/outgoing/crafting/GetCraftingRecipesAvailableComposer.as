package com.sulake.habbo.communication.messages.outgoing.crafting {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class GetCraftingRecipesAvailableComposer implements IMessageComposer, IDisposable {

        public function GetCraftingRecipesAvailableComposer(param1: int, param2: Vector.<int>) {
            var _loc3_: int = 0;
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2.length);
            _loc3_ = 0;
            while (_loc3_ < param2.length) {
                var_20.push(param2[_loc3_]);
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
