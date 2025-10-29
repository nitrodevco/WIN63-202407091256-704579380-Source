package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class SetMannequinFigureComposer implements IMessageComposer {

        public function SetMannequinFigureComposer(param1: int) {
            super();
            var_603 = param1;
        }
        private var var_603: int;

        public function getMessageArray(): Array {
            return [var_603];
        }

        public function dispose(): void {
        }
    }
}
