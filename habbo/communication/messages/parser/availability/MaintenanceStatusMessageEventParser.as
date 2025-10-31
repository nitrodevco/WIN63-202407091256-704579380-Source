package com.sulake.habbo.communication.messages.parser.availability {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MaintenanceStatusMessageEventParser implements IMessageParser {

        public function MaintenanceStatusMessageEventParser() {
            super();
        }
        private var var_1258: Boolean;
        private var var_1315: int;
        private var var_377: int = 15;

        public function get isInMaintenance(): Boolean {
            return var_1258;
        }

        public function get minutesUntilMaintenance(): int {
            return var_1315;
        }

        public function get duration(): int {
            return var_377;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1258 = param1.readBoolean();
            var_1315 = param1.readInteger();
            if (param1.bytesAvailable) {
                var_377 = param1.readInteger();
            }
            return true;
        }
    }
}
