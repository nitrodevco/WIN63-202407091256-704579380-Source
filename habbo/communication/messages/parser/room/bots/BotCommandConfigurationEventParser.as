package com.sulake.habbo.communication.messages.parser.room.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class BotCommandConfigurationEventParser implements IMessageParser {

        public function BotCommandConfigurationEventParser() {
            super();
        }
        private var var_536: int;
        private var var_376: int;
        private var var_47: String;

        public function get botId(): int {
            return var_536;
        }

        public function get commandId(): int {
            return var_376;
        }

        public function get data(): String {
            return var_47;
        }

        public function flush(): Boolean {
            var_536 = -1;
            var_376 = -1;
            var_47 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_536 = param1.readInteger();
            var_376 = param1.readInteger();
            var_47 = param1.readString();
            return true;
        }
    }
}
