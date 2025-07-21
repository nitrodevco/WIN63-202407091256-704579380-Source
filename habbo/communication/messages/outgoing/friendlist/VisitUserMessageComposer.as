package com.sulake.habbo.communication.messages.outgoing.friendlist {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class VisitUserMessageComposer implements IMessageComposer {

        public function VisitUserMessageComposer(param1: String) {
            super();
            _username = param1;
        }
        private var _username: String;

        public function getMessageArray(): Array {
            return [_username];
        }

        public function dispose(): void {
            _username = null;
        }
    }
}
