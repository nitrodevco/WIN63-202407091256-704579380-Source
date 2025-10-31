package com.sulake.habbo.communication.messages.parser.avatar {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ChangeUserNameResultMessageEventParser implements IMessageParser {

        public function ChangeUserNameResultMessageEventParser() {
            super();
        }
        private var var_296: int = -1;
        private var var_273: Array;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get resultCode(): int {
            return var_296;
        }

        public function get nameSuggestions(): Array {
            return var_273;
        }

        public function flush(): Boolean {
            var_296 = -1;
            _name = "";
            var_273 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_296 = param1.readInteger();
            _name = param1.readString();
            var _loc2_: int = param1.readInteger();
            var_273 = [];
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_273.push(param1.readString());
                _loc3_++;
            }
            return true;
        }
    }
}
