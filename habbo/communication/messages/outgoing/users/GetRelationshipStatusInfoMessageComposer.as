package com.sulake.habbo.communication.messages.outgoing.users {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetRelationshipStatusInfoMessageComposer implements IMessageComposer {

        public function GetRelationshipStatusInfoMessageComposer(param1: int) {
            var_47 = [];
            super();
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
