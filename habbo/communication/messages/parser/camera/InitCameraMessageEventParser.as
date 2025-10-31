package com.sulake.habbo.communication.messages.parser.camera {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class InitCameraMessageEventParser implements IMessageParser {

        public function InitCameraMessageEventParser() {
            super();
        }
        private var var_625: int = 0;
        private var var_530: int = 0;
        private var var_637: int = 0;

        public function getCreditPrice(): int {
            return var_625;
        }

        public function getDucketPrice(): int {
            return var_530;
        }

        public function getPublishDucketPrice(): int {
            return var_637;
        }

        public function flush(): Boolean {
            var_625 = 0;
            var_530 = 0;
            var_637 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_625 = param1.readInteger();
            var_530 = param1.readInteger();
            if (param1.bytesAvailable > 0) {
                var_637 = param1.readInteger();
            }
            return true;
        }
    }
}
