package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1702 extends class_1659 {

        public function class_1702(param1: IMessageDataWrapper) {
            super(param1);
        }
        private var var_866: int;

        public function get delayInPulses(): int {
            return var_866;
        }

        override protected function readDefinitionSpecifics(param1: IMessageDataWrapper): void {
            var_866 = param1.readInteger();
        }
    }
}
