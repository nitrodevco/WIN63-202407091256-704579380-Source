package com.sulake.habbo.communication.messages.incoming.hotlooks {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1636 {

        public function class_1636(param1: IMessageDataWrapper) {
            super();
            var_129 = param1.readString();
            _figureString = param1.readString();
        }
        private var var_129: String;

        private var _figureString: String;

        public function get figureString(): String {
            return _figureString;
        }

        public function get gender(): String {
            return var_129;
        }
    }
}
