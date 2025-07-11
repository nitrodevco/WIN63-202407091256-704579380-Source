package com.sulake.habbo.communication.messages.outgoing.nux {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class NewUserExperienceGetGiftsMessageComposer implements IMessageComposer, IDisposable {

        public function NewUserExperienceGetGiftsMessageComposer(param1: Vector.<class_1232>) {
            var_20 = [];
            super();
            var_20.push(param1.length * 3);
            for each(var _loc2_ in param1) {
                var_20.push(_loc2_.dayIndex);
                var_20.push(_loc2_.stepIndex);
                var_20.push(_loc2_.giftIndex);
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
