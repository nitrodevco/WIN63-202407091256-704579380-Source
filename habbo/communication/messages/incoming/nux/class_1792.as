package com.sulake.habbo.communication.messages.incoming.nux {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1792 {

        public function class_1792(param1: IMessageDataWrapper) {
            super();
            var_394 = param1.readString();
            _localizationKey = param1.readString();
            if (_localizationKey == "") {
                _localizationKey = null;
            }
        }
        private var var_394: String;

        private var _localizationKey: String;

        public function get localizationKey(): String {
            return _localizationKey;
        }

        public function get productCode(): String {
            return var_394;
        }
    }
}
