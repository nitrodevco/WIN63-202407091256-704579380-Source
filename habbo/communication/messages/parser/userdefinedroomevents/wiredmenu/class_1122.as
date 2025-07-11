package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredHoldingVariablesData

    public class class_1122 implements IMessageParser {

        public function class_1122() {
            super();
        }
        private var var_47: WiredHoldingVariablesData;

        public function get data(): WiredHoldingVariablesData {
            return var_47;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new WiredHoldingVariablesData(param1);
            return true;
        }
    }
}
