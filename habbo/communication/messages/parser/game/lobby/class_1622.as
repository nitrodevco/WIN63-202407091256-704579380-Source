package com.sulake.habbo.communication.messages.parser.game.lobby {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1622 implements IMessageParser {

        public function class_1622() {
            super();
        }
        private var var_435: int;

        private var var_487: String;

        private var var_403: int;

        private var var_381: int;

        private var _stuffId: int;

        public function get stuffId(): int {
            return _stuffId;
        }

        private var _endTime: int;

        public function get endTime(): int {
            return _endTime;
        }

        public function get achievementId(): int {
            return var_435;
        }

        public function get requiredLevelBadgeCode(): String {
            return var_487;
        }

        public function get userProgress(): int {
            return var_403;
        }

        public function get totalProgress(): int {
            return var_381;
        }

        public function flush(): Boolean {
            _stuffId = -1;
            var_435 = 0;
            var_487 = "";
            var_403 = 0;
            var_381 = 0;
            _endTime = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _stuffId = param1.readInteger();
            var_435 = param1.readInteger();
            var_487 = param1.readString();
            var_403 = param1.readInteger();
            var_381 = param1.readInteger();
            _endTime = param1.readInteger();
            return true;
        }
    }
}
