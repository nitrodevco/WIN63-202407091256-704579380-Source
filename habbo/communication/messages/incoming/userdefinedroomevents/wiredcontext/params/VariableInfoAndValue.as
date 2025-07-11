package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable

    public class VariableInfoAndValue {

        public function VariableInfoAndValue(param1: IMessageDataWrapper) {
            super();
            var_1318 = new WiredVariable(param1);
            _value = param1.readInteger();
        }
        private var var_1318: WiredVariable;

        private var _value: int;

        public function get value(): int {
            return _value;
        }

        public function get variable(): WiredVariable {
            return var_1318;
        }
    }
}
