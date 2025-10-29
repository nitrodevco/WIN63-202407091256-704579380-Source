package com.sulake.habbo.communication.messages.outgoing.room.bots {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class CommandBotComposer implements IMessageComposer {

        public function CommandBotComposer(param1: int, param2: int, param3: String) {
            super();
            var_536 = param1;
            var_889 = param2;
            var_819 = param3;
        }
        private var var_536: int;
        private var var_889: int;
        private var var_819: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_536, var_889, var_819];
        }
    }
}
