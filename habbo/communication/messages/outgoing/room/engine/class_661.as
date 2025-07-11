package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.utils.Map

   [SecureSWF(rename="true")]
    public class class_661 implements IMessageComposer {

        public function class_661(param1: int, param2: Map) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2.length * 2);
            for each(var _loc3_ in param2.getKeys()) {
                var_47.push(_loc3_);
                var_47.push(param2.getValue(_loc3_));
            }
        }
        private var var_47: Array;

        public function dispose(): void {
            var_47 = null;
        }

        public function getMessageArray(): Array {
            return var_47;
        }
    }
}
