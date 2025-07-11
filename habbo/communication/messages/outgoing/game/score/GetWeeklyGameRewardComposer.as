package com.sulake.habbo.communication.messages.outgoing.game.score {
   import com.sulake.core.communication.messages.IMessageComposer

   public class GetWeeklyGameRewardComposer implements IMessageComposer {

        public function GetWeeklyGameRewardComposer(param1: int) {
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
