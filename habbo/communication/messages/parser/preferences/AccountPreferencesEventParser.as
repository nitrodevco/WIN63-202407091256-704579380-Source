package com.sulake.habbo.communication.messages.parser.preferences {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class AccountPreferencesEventParser implements IMessageParser {

        public function AccountPreferencesEventParser() {
            super();
        }
        private var var_493: Boolean;
        private var var_1014: Boolean;
        private var var_558: Boolean;
        private var var_533: int;
        private var var_650: int;
        private var var_434: Boolean;
        private var var_611: Boolean;
        private var var_397: Boolean;
        private var var_481: int;

        private var _traxVolume: int;

        public function get traxVolume(): int {
            return _traxVolume;
        }

        private var _furniVolume: int;

        public function get furniVolume(): int {
            return _furniVolume;
        }

        private var _uiVolume: int;

        public function get uiVolume(): int {
            return _uiVolume;
        }

        public function get freeFlowChatDisabled(): Boolean {
            return var_493;
        }

        public function get roomInvitesIgnored(): Boolean {
            return var_1014;
        }

        public function get roomCameraFollowDisabled(): Boolean {
            return var_558;
        }

        public function get uiFlags(): int {
            return var_533;
        }

        public function get preferedChatStyle(): int {
            return var_650;
        }

        public function get wiredMenuButton(): Boolean {
            return var_434;
        }

        public function get wiredInspectButton(): Boolean {
            return var_611;
        }

        public function get playTestMode(): Boolean {
            return var_397;
        }

        public function get variableSyntaxMode(): int {
            return var_481;
        }

        public function flush(): Boolean {
            var_493 = false;
            var_558 = false;
            var_533 = 0;
            var_650 = 0;
            var_434 = false;
            var_611 = false;
            var_397 = false;
            var_481 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _uiVolume = param1.readInteger();
            _furniVolume = param1.readInteger();
            _traxVolume = param1.readInteger();
            var_493 = param1.readBoolean();
            var_1014 = param1.readBoolean();
            var_558 = param1.readBoolean();
            var_533 = param1.readInteger();
            var_650 = param1.readInteger();
            var_434 = param1.readBoolean();
            var_611 = param1.readBoolean();
            var_397 = param1.readBoolean();
            var_481 = param1.readInteger();
            return true;
        }
    }
}
