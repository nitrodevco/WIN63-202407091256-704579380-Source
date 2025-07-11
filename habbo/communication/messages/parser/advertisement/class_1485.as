package com.sulake.habbo.communication.messages.parser.advertisement {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1485 implements IMessageParser {

        public function class_1485() {
            super();
        }
        private var var_640: Boolean;

        public function get canShowInterstitial(): Boolean {
            return var_640;
        }

        public function flush(): Boolean {
            var_640 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_640 = param1.readBoolean();
            return true;
        }
    }
}
