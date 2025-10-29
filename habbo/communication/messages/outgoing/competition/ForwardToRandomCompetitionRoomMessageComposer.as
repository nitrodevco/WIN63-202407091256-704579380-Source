package com.sulake.habbo.communication.messages.outgoing.competition {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class ForwardToRandomCompetitionRoomMessageComposer implements IMessageComposer {

        public function ForwardToRandomCompetitionRoomMessageComposer(param1: String) {
            var_20 = [];
            super();
            this.var_20.push(param1);
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
