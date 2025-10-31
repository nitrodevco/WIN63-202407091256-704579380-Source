package com.sulake.habbo.communication.messages.parser.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1701

    [SecureSWF(rename="true")]
    public class WiredFurniTriggerEventParser implements IMessageParser {

        public function WiredFurniTriggerEventParser() {
            super();
        }
        private var var_380: class_1701;

        public function get def(): class_1701 {
            return var_380;
        }

        public function flush(): Boolean {
            var_380 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_380 = new class_1701(param1);
            return true;
        }
    }
}
