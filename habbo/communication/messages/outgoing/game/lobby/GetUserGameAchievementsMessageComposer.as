package com.sulake.habbo.communication.messages.outgoing.game.lobby {
   import com.sulake.core.communication.messages.IMessageComposer

   public class GetUserGameAchievementsMessageComposer implements IMessageComposer {

        public function GetUserGameAchievementsMessageComposer(param1: int) {
            super();
            var_474 = param1;
        }
        private var var_474: int;

        public function getMessageArray(): Array {
            return [var_474];
        }

        public function dispose(): void {
        }
    }
}
