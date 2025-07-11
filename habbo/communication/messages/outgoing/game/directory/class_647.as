package com.sulake.habbo.communication.messages.outgoing.game.directory {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_647 implements IMessageComposer {

        public function class_647() {
            var_47 = [];
            super();
        }
        private var var_47: Array;

        public function getMessageArray(): Array {
            return var_47;
        }

        public function dispose(): void {
            var_47 = [];
        }
    }
}
