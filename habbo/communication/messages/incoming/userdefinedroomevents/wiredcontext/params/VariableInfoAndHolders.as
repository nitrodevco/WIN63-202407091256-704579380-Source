package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.ObjectIdAndValuePair
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable

    public class VariableInfoAndHolders {

        public function VariableInfoAndHolders(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            super();
            var_1318 = new WiredVariable(param1);
            var_670 = new Vector.<ObjectIdAndValuePair>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_670.push(new ObjectIdAndValuePair(param1));
                _loc3_++;
            }
        }
        private var var_1318: WiredVariable;
        private var var_670: Vector.<ObjectIdAndValuePair>;

        public function get variable(): WiredVariable {
            return var_1318;
        }

        public function get holders(): Vector.<ObjectIdAndValuePair> {
            return var_670;
        }
    }
}
