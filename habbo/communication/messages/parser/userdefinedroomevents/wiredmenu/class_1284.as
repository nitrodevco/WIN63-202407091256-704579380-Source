package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class class_1284 implements IMessageParser {

        public static var var_1606: int = 0;

        public static var var_1625: int = 1;

        public static var var_1614: int = 2;

        public function class_1284() {
            super();
        }
        private var var_412: int;

        public function get errorCode(): int {
            return var_412;
        }

        public function flush(): Boolean {
            var_412 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_412 = param1.readShort();
            return true;
        }
    }
}
