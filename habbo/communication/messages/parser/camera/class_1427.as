package com.sulake.habbo.communication.messages.parser.camera {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1427 implements IMessageParser {

        public function class_1427() {
            super();
        }
        private var var_344: Boolean = true;
        private var var_567: Boolean = false;

        public function isOk(): Boolean {
            return var_344;
        }

        public function isRenderLimitHit(): Boolean {
            return var_567;
        }

        public function flush(): Boolean {
            var_344 = true;
            var_567 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1.bytesAvailable) {
                var_344 = param1.readBoolean();
                var_567 = param1.readBoolean();
            }
            return true;
        }
    }
}
