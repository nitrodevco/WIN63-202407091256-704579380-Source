package com.sulake.habbo.communication.messages.outgoing.room.action {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class AmbassadorAlertMessageComposer implements IMessageComposer {

        public function AmbassadorAlertMessageComposer(param1: int) {
            super();
            var_418 = param1;
        }
        private var var_418: int;

        public function getMessageArray(): Array {
            return [var_418];
        }

        public function dispose(): void {
        }
    }
}
