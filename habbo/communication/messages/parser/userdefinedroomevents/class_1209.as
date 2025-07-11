package com.sulake.habbo.communication.messages.parser.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition

    public class class_1209 implements IMessageParser {

        public function class_1209() {
            super();
        }
        private var var_380: SelectorDefinition;

        public function get def(): SelectorDefinition {
            return var_380;
        }

        public function flush(): Boolean {
            var_380 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_380 = new SelectorDefinition(param1);
            return true;
        }
    }
}
