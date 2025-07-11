package com.sulake.habbo.communication.messages.parser.room.action {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1175 implements IMessageParser {

        public function class_1175() {
            super();
        }
        private var var_418: int = 0;
        private var var_404: int = -1;

        public function get userId(): int {
            return var_418;
        }

        public function get expressionType(): int {
            return var_404;
        }

        public function flush(): Boolean {
            var_418 = 0;
            var_404 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            var_404 = param1.readInteger();
            return true;
        }
    }
}
