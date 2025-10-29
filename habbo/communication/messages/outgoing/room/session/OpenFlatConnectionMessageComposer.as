package com.sulake.habbo.communication.messages.outgoing.room.session {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class OpenFlatConnectionMessageComposer implements IMessageComposer {

        public function OpenFlatConnectionMessageComposer(param1: int, param2: String = "", param3: int = -1) {
            super();
            var_368 = [param1, param2, param3];
        }
        private var var_368: Array;

        public function dispose(): void {
            var_368 = null;
        }

        public function getMessageArray(): Array {
            return var_368;
        }
    }
}
