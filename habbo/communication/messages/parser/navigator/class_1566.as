package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1566 implements IMessageParser {

        public function class_1566() {
            super();
        }
        private var var_296: int;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function get resultCode(): int {
            return var_296;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._flatId = param1.readInteger();
            this.var_296 = param1.readInteger();
            return true;
        }
    }
}
