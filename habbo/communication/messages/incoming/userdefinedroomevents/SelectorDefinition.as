package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class SelectorDefinition extends class_1659 {

        public function SelectorDefinition(param1: IMessageDataWrapper) {
            super(param1);
        }
        private var var_1437: Boolean;
        private var var_1013: Boolean;

        public function get isFilter(): Boolean {
            return var_1437;
        }

        public function get isInvert(): Boolean {
            return var_1013;
        }

        override protected function readDefinitionSpecifics(param1: IMessageDataWrapper): void {
            var_1437 = param1.readBoolean();
            var_1013 = param1.readBoolean();
        }
    }
}
