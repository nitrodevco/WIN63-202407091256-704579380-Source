package com.sulake.habbo.communication.messages.outgoing.competition {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_749 implements IMessageComposer {

        public static const const_162: int = 0;

        public static const const_393: int = 1;

        public static const const_87: int = 2;

        public static const const_365: int = 3;

        public function class_749(param1: String, param2: int) {
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
