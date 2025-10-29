package com.sulake.habbo.communication.messages.outgoing.quest {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetDailyQuestMessageComposer implements IMessageComposer {

        public function GetDailyQuestMessageComposer(param1: Boolean, param2: int) {
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
