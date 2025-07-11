package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1126 implements IMessageParser {

        public function class_1126() {
            super();
        }
        private var var_591: Boolean = false;
        private var var_620: Boolean = false;
        private var var_452: int = 0;

        public function get notEnoughCredits(): Boolean {
            return var_591;
        }

        public function get notEnoughActivityPoints(): Boolean {
            return var_620;
        }

        public function get activityPointType(): int {
            return var_452;
        }

        public function flush(): Boolean {
            var_591 = false;
            var_620 = false;
            var_452 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_591 = param1.readBoolean();
            var_620 = param1.readBoolean();
            if (param1.bytesAvailable) {
                var_452 = param1.readInteger();
            }
            return true;
        }
    }
}
