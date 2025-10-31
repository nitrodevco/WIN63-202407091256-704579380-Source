package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ModeratorToolPreferencesEventParser implements IMessageParser {

        public function ModeratorToolPreferencesEventParser() {
            super();
        }
        private var var_466: int;
        private var var_379: int;
        private var var_442: int;

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

        public function flush(): Boolean {
            var_466 = 0;
            var_379 = 0;
            _windowWidth = 0;
            var_442 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_466 = param1.readInteger();
            var_379 = param1.readInteger();
            _windowWidth = param1.readInteger();
            var_442 = param1.readInteger();
            return true;
        }
    }
}
