package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable

    public class AllVariablesInRoom extends class_1791 {

        public function AllVariablesInRoom(param1: IMessageDataWrapper) {
            super();
            var_468 = param1.readInteger();
        }
        private var var_468: int;
        private var var_353: Array = null;

        override public function get variables(): Array {
            return var_353;
        }

        public function get needsSynchronize(): Boolean {
            return var_353 == null;
        }

        public function get hash(): int {
            return var_468;
        }

        public function synchronize(param1: Vector.<WiredVariable>): void {
            var_353 = [];
            for each(var _loc2_ in param1) {
                var_353.push(_loc2_);
            }
        }
    }
}
