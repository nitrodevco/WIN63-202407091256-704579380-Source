package com.sulake.habbo.communication.messages.outgoing.room.bots {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class GetBotCommandConfigurationDataComposer implements IMessageComposer {

        public function GetBotCommandConfigurationDataComposer(param1: int, param2: int) {
            super();
            var_536 = param1;
            var_889 = param2;
        }
        private var var_536: int;
        private var var_889: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_536, var_889];
        }
    }
}
