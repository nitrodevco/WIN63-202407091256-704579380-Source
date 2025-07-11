package com.sulake.habbo.communication.messages.outgoing.room.engine {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SetItemDataMessageComposer implements IMessageComposer {

        public function SetItemDataMessageComposer(param1: int, param2: String = "", param3: String = "") {
            super();
            var_455 = param1;
            var_47 = param3;
            var_821 = param2;
        }
        private var var_455: int;
        private var var_47: String;
        private var var_821: String;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_455, var_821, var_47];
        }
    }
}
