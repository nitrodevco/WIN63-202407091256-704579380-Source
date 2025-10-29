package com.sulake.habbo.communication.messages.outgoing.userclassification {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class RoomUsersClassificationMessageComposer implements IMessageComposer {

        public function RoomUsersClassificationMessageComposer(param1: String) {
            super();
            var_544 = param1;
        }
        private var var_544: String;

        public function getMessageArray(): Array {
            return [var_544];
        }

        public function dispose(): void {
            var_544 = null;
        }
    }
}
