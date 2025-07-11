package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1708 {

        public function class_1708(param1: IMessageDataWrapper) {
            super();
            var_1335 = param1.readInteger();
            var_1481 = param1.readString();
            var_638 = param1.readString();
            var_895 = param1.readInteger();
            var_918 = param1.readLong();
        }
        private var var_1335: int;
        private var var_1481: String;
        private var var_638: String;
        private var var_895: int;
        private var var_918: Number;

        public function get errorId(): int {
            return var_1335;
        }

        public function get errorName(): String {
            return var_1481;
        }

        public function get category(): String {
            return var_638;
        }

        public function get throwCount(): int {
            return var_895;
        }

        public function get msSinceLastOccurrence(): Number {
            return var_918;
        }
    }
}
