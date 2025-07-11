package com.sulake.habbo.communication.messages.outgoing.room.furniture {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_967 implements IMessageComposer {

        public function class_967(param1: int, param2: String) {
            super();
            var_603 = param1;
            _name = param2;
        }
        private var var_603: int;
        private var _name: String;

        public function getMessageArray(): Array {
            return [var_603, _name];
        }

        public function dispose(): void {
        }
    }
}
