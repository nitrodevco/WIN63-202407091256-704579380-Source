package com.sulake.habbo.communication.messages.parser.mysterybox {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1470 implements IMessageParser {

        public function class_1470() {
            super();
        }

        private var _boxColor: String;

        public function get boxColor(): String {
            return _boxColor;
        }

        private var _keyColor: String;

        public function get keyColor(): String {
            return _keyColor;
        }

        public function flush(): Boolean {
            _boxColor = null;
            _keyColor = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _boxColor = param1.readString();
            _keyColor = param1.readString();
            return true;
        }
    }
}
