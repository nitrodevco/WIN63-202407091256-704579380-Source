package com.sulake.habbo.communication.messages.parser.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1323 implements IMessageParser {

        public function class_1323() {
            super();
        }
        private var var_466: int;
        private var var_379: int;
        private var var_442: int;

        private var var_599: Boolean;

        private var var_602: int;

        private var _windowWidth: int;

        public function get windowWidth(): int {
            return _windowWidth;
        }

        public function get windowX(): int {
            return var_466;
        }

        public function get windowY(): int {
            return var_379;
        }

        public function get windowHeight(): int {
            return var_442;
        }

        public function get leftPaneHidden(): Boolean {
            return var_599;
        }

        public function get resultsMode(): int {
            return var_602;
        }

        public function flush(): Boolean {
            var_466 = 0;
            var_379 = 0;
            _windowWidth = 0;
            var_442 = 0;
            var_599 = false;
            var_602 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_466 = param1.readInteger();
            var_379 = param1.readInteger();
            _windowWidth = param1.readInteger();
            var_442 = param1.readInteger();
            var_599 = param1.readBoolean();
            var_602 = param1.readInteger();
            return true;
        }
    }
}
