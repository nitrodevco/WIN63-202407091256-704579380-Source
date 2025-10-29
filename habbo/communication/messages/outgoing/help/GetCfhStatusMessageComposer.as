package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetCfhStatusMessageComposer implements IMessageComposer {

        public function GetCfhStatusMessageComposer(param1: Boolean) {
            super();
            var_852 = param1;
        }
        private var var_852: Boolean;

        public function getMessageArray(): Array {
            return [var_852];
        }

        public function dispose(): void {
        }
    }
}
