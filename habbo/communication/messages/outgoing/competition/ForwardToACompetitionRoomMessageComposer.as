package com.sulake.habbo.communication.messages.outgoing.competition {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class ForwardToACompetitionRoomMessageComposer implements IMessageComposer {

        public function ForwardToACompetitionRoomMessageComposer(param1: String, param2: int) {
            var_20 = [];
            super();
            this.var_20.push(param1);
            this.var_20.push(param2);
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
