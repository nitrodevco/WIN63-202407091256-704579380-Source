package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class YoutubeControlVideoMessageEventParser implements IMessageParser {

        public function YoutubeControlVideoMessageEventParser() {
            super();
        }
        private var var_603: int;
        private var var_376: int;

        public function get furniId(): int {
            return var_603;
        }

        public function get commandId(): int {
            return var_376;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_603 = param1.readInteger();
            var_376 = param1.readInteger();
            return true;
        }
    }
}
