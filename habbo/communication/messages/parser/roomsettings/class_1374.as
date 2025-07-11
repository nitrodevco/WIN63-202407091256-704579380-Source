package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1374 implements IMessageParser {

        public function class_1374() {
            super();
        }
        private var var_1455: Boolean;

        public function get allMuted(): Boolean {
            return var_1455;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1455 = param1.readBoolean();
            return true;
        }

        public function flush(): Boolean {
            return true;
        }
    }
}
