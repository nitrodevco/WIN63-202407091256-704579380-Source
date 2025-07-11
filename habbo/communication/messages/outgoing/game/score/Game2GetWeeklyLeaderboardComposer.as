package com.sulake.habbo.communication.messages.outgoing.game.score {
   import com.sulake.core.communication.messages.IMessageComposer

   public class Game2GetWeeklyLeaderboardComposer implements IMessageComposer {

        public function Game2GetWeeklyLeaderboardComposer(param1: int, param2: int, param3: int, param4: int, param5: int, param6: int) {
            var_47 = [];
            super();
            var_47.push(param1);
            var_47.push(param2);
            var_47.push(param3);
            var_47.push(param4);
            var_47.push(param5);
            var_47.push(param6);
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
