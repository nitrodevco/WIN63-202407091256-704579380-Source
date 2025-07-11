package com.sulake.habbo.communication.messages.outgoing.game.lobby {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetResolutionAchievementsMessageComposer implements IMessageComposer {

        public function GetResolutionAchievementsMessageComposer(param1: int, param2: int = 0) {
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
            var_47 = [];
        }
    }
}
