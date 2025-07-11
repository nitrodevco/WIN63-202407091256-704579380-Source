package com.sulake.habbo.communication.messages.outgoing.users {
    import com.sulake.core.communication.messages.IMessageComposer

    [SecureSWF(rename="true")]
    public class class_1037 implements IMessageComposer {

        public function class_1037(param1: int) {
            super();
            var_364 = param1;
        }
        private var var_364: int;

        public function getMessageArray(): Array {
            return [var_364];
        }

        public function dispose(): void {
        }
    }
}
