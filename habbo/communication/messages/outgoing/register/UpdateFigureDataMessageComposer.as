package com.sulake.habbo.communication.messages.outgoing.register {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class UpdateFigureDataMessageComposer implements IMessageComposer {

        public function UpdateFigureDataMessageComposer(param1: String, param2: String) {
            var_47 = [];
            super();
            var_47.push(param2);
            var_47.push(param1);
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = null;
        }
    }
}
