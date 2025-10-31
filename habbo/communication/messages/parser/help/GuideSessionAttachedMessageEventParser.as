package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuideSessionAttachedMessageEventParser implements IMessageParser {

        public function GuideSessionAttachedMessageEventParser() {
            super();
        }
        private var var_1153: Boolean;
        private var var_1444: int;
        private var var_1289: String;
        private var var_892: int;

        public function get asGuide(): Boolean {
            return var_1153;
        }

        public function get helpRequestType(): int {
            return var_1444;
        }

        public function get helpRequestDescription(): String {
            return var_1289;
        }

        public function get roleSpecificWaitTime(): int {
            return var_892;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1153 = param1.readBoolean();
            var_1444 = param1.readInteger();
            var_1289 = param1.readString();
            var_892 = param1.readInteger();
            return true;
        }
    }
}
