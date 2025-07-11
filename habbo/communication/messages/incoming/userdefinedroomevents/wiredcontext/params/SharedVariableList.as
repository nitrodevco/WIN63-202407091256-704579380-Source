package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.SharedVariable

    public class SharedVariableList extends class_1791 {

        public function SharedVariableList(param1: IMessageDataWrapper) {
            var _loc4_: int = 0;
            var _loc3_: SharedVariable = null;
            var_667 = [];
            var_353 = [];
            super();
            var _loc2_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_ = new SharedVariable(param1);
                var_667.push(_loc3_);
                var_353.push(_loc3_.wiredVariable);
                _loc4_++;
            }
        }
        private var var_667: Array;
        private var var_353: Array;

        override public function get variables(): Array {
            return var_353;
        }

        public function get sharedVariables(): Array {
            return var_667;
        }
    }
}
