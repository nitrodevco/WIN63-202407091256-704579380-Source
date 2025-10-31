package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class HabboActivityPointNotificationMessageEventParser implements IMessageParser {

        public function HabboActivityPointNotificationMessageEventParser() {
            super();
        }
        private var var_1275: int = 0;

        private var var_329: int;

        private var _amount: int = 0;

        public function get amount(): int {
            return _amount;
        }

        public function get change(): int {
            return var_1275;
        }

        public function get type(): int {
            return var_329;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _amount = param1.readInteger();
            var_1275 = param1.readInteger();
            var_329 = param1.readInteger();
            return true;
        }
    }
}
