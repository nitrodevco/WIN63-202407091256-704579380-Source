package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class WiredPermissionsEventParser implements IMessageParser {

        public function WiredPermissionsEventParser() {
            super();
        }
        private var var_646: Boolean;
        private var var_463: Boolean;

        public function get canModify(): Boolean {
            return var_646;
        }

        public function get canRead(): Boolean {
            return var_463;
        }

        public function flush(): Boolean {
            var_646 = false;
            var_463 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_646 = param1.readBoolean();
            var_463 = param1.readBoolean();
            return true;
        }
    }
}
