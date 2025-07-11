package com.sulake.habbo.communication.messages.outgoing.game.score {
   import com.sulake.core.communication.messages.IMessageComposer

   public class GetWeeklyCompetitiveLeaderboardComposer implements IMessageComposer {

        public function GetWeeklyCompetitiveLeaderboardComposer(param1: int, param2: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
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
