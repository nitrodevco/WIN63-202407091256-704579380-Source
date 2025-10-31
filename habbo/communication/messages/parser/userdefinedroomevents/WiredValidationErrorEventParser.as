package com.sulake.habbo.communication.messages.parser.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1752

    [SecureSWF(rename="true")]
    public class WiredValidationErrorEventParser implements IMessageParser {

        public function WiredValidationErrorEventParser() {
            super();
        }

        private var _localizationKey: String;

        public function get localizationKey(): String {
            return _localizationKey;
        }

        private var _parameters: Array;

        public function get parameters(): Array {
            return _parameters;
        }

        public function flush(): Boolean {
            _localizationKey = null;
            _parameters = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            _localizationKey = param1.readString();
            _parameters = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _parameters.push(new class_1752(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
