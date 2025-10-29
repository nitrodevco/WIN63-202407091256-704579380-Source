package com.sulake.habbo.communication.messages.outgoing.room.layout {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class UpdateFloorPropertiesMessageComposer implements IMessageComposer {

        public function UpdateFloorPropertiesMessageComposer(param1: String, param2: int = -1, param3: int = -1, param4: int = -1, param5: int = -1, param6: int = -1, param7: int = -1) {
            super();
            if (param2 == -1 && param3 == -1 && param4 == -1 && param5 == -1 && param6 == -1) {
                var_20 = [param1];
            } else if (param7 == -1) {
                var_20 = [param1, param2, param3, param4, param5, param6];
            } else {
                var_20 = [param1, param2, param3, param4, param5, param6, param7];
            }
        }
        private var var_20: Array;

        public function getMessageArray(): Array {
            return var_20;
        }

        public function dispose(): void {
            var_20 = null;
        }
    }
}
