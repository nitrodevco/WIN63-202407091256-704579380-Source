package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuideOnDutyStatusMessageEventParser implements IMessageParser {

        public function GuideOnDutyStatusMessageEventParser() {
            super();
        }
        private var var_1068: int;

        private var var_1448: int;

        private var var_1480: int;

        private var _onDuty: Boolean;

        public function get onDuty(): Boolean {
            return _onDuty;
        }

        public function get helpersOnDuty(): int {
            return var_1448;
        }

        public function get guardiansOnDuty(): int {
            return var_1480;
        }

        public function get guidesOnDuty(): int {
            return var_1068;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _onDuty = param1.readBoolean();
            var_1068 = param1.readInteger();
            var_1448 = param1.readInteger();
            var_1480 = param1.readInteger();
            return true;
        }
    }
}
