package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1660 extends class_1659 {

        public function class_1660(param1: IMessageDataWrapper) {
            super(param1);
        }
        private var var_1077: int;
        private var var_1098: int;
        private var var_1013: Boolean;

        override public function get usingCustomInputSources(): Boolean {
            return super.usingCustomInputSources || quantifierCode != 0;
        }

        public function get quantifierCode(): int {
            return var_1077;
        }

        public function get quantifierType(): int {
            return var_1098;
        }

        public function get isInvert(): Boolean {
            return var_1013;
        }

        override protected function readDefinitionSpecifics(param1: IMessageDataWrapper): void {
            var_1077 = param1.readInteger();
        }

        override protected function readTypeSpecifics(param1: IMessageDataWrapper): void {
            var_1098 = param1.readByte();
            var_1013 = param1.readBoolean();
        }
    }
}
