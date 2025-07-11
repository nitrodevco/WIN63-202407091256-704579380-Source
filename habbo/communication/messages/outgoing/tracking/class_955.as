package com.sulake.habbo.communication.messages.outgoing.tracking {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_955 implements IMessageComposer {

        public function class_955(param1: String, param2: String, param3: String, param4: String = "", param5: int = 0) {
            super();
            var_638 = !!param1 ? param1 : "";
            var_329 = !!param2 ? param2 : "";
            _action = !!param3 ? param3 : "";
            _extraString = !!param4 ? param4 : "";
            var_1483 = !!param5 ? param5 : 0;
        }
        private var var_638: String;
        private var var_329: String;
        private var _action: String;
        private var _extraString: String;
        private var var_1483: int;

        public function dispose(): void {
        }

        public function getMessageArray(): Array {
            return [var_638, var_329, _action, _extraString, var_1483];
        }
    }
}
