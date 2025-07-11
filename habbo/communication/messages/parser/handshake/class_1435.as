package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1435 implements IMessageParser {

        public function class_1435() {
            super();
        }
        private var var_842: int;
        private var var_1393: int;

        private var _isAmbassador: Boolean;

        public function get isAmbassador(): Boolean {
            return _isAmbassador;
        }

        public function get clubLevel(): int {
            return var_842;
        }

        public function get securityLevel(): int {
            return var_1393;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_842 = param1.readInteger();
            var_1393 = param1.readInteger();
            _isAmbassador = param1.readBoolean();
            return true;
        }
    }
}
