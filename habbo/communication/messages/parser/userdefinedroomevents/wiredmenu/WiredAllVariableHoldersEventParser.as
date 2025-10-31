package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableInfoAndHolders

    public class WiredAllVariableHoldersEventParser implements IMessageParser {

        public function WiredAllVariableHoldersEventParser() {
            super();
        }
        private var var_566: VariableInfoAndHolders;

        public function get variableInfoAndHolders(): VariableInfoAndHolders {
            return var_566;
        }

        public function flush(): Boolean {
            var_566 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            param1.readInteger();
            var_566 = new VariableInfoAndHolders(param1);
            return true;
        }
    }
}
