package com.sulake.habbo.communication.messages.parser.availability {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1423 implements IMessageParser {

        public function class_1423() {
            super();
        }
        private var var_386: int;

        private var _isOpen: Boolean;

        public function get isOpen(): Boolean {
            return _isOpen;
        }

        public function get minutesUntilChange(): int {
            return var_386;
        }

        public function flush(): Boolean {
            _isOpen = false;
            var_386 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _isOpen = param1.readInteger() > 0;
            var_386 = param1.readInteger();
            return true;
        }
    }
}
