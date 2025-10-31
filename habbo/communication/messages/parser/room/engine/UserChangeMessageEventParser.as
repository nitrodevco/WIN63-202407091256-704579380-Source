package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class UserChangeMessageEventParser implements IMessageParser {

        public function UserChangeMessageEventParser() {
            super();
        }
        private var var_280: int;
        private var var_426: String;
        private var var_139: String;

        private var _customInfo: String;

        public function get customInfo(): String {
            return _customInfo;
        }

        private var _achievementScore: int;

        public function get achievementScore(): int {
            return _achievementScore;
        }

        public function get id(): int {
            return var_280;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get sex(): String {
            return var_139;
        }

        public function flush(): Boolean {
            var_280 = 0;
            var_426 = "";
            var_139 = "";
            _customInfo = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_280 = param1.readInteger();
            var_426 = param1.readString();
            var_139 = param1.readString();
            _customInfo = param1.readString();
            _achievementScore = param1.readInteger();
            if (var_139) {
                var_139 = var_139.toUpperCase();
            }
            return true;
        }
    }
}
