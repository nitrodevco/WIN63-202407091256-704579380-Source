package com.sulake.habbo.communication.messages.parser.room.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class BotForceOpenContextMenuEventParser implements IMessageParser {

        public function BotForceOpenContextMenuEventParser() {
            super();
        }
        private var var_536: int;

        public function get botId(): int {
            return var_536;
        }

        public function flush(): Boolean {
            var_536 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_536 = param1.readInteger();
            return true;
        }
    }
}
