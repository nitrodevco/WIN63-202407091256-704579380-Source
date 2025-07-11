package com.sulake.habbo.communication.messages.outgoing.landingview.votes {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class CommunityGoalVoteMessageComposer implements IMessageComposer {

        public function CommunityGoalVoteMessageComposer(param1: int) {
            super();
            this.var_1570 = param1;
        }
        private var var_1570: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_1570];
        }
    }
}
