package com.sulake.habbo.communication.messages.parser.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1737

    [SecureSWF(rename="true")]
    public class WiredFurniVariableEventParser implements IMessageParser {

        public function WiredFurniVariableEventParser() {
            super();
        }
        private var var_380: class_1737;

        public function get def(): class_1737 {
            return var_380;
        }

        public function flush(): Boolean {
            var_380 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_380 = new class_1737(param1);
            return true;
        }
    }
}
