package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageComposer
    import com.sulake.core.communication.util.Long
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class UpdateConditionMessageComposer implements IMessageComposer, IDisposable {

        public function UpdateConditionMessageComposer(param1: int, param2: Array, param3: Array, param4: String, param5: Array, param6: int, param7: Array, param8: Array) {
            var_20 = [];
            super();
            var_20.push(param1);
            var_20.push(param2.length);
            for each(var _loc11_ in param2) {
                var_20.push(_loc11_);
            }
            var_20.push(param4);
            var_20.push(param5.length);
            for each(var _loc12_ in param5) {
                var_20.push(_loc12_);
            }
            var_20.push(param6);
            var_20.push(param7.length);
            for each(var _loc9_ in param7) {
                var_20.push(_loc9_);
            }
            var_20.push(param8.length);
            for each(var _loc13_ in param8) {
                var_20.push(_loc13_);
            }
            var_20.push(param3.length);
            for each(var _loc10_ in param3) {
                var_20.push(new Long(_loc10_));
            }
        }
        private var var_20: Array;

        public function get disposed(): Boolean {
            return false;
        }

        public function getMessageArray(): Array {
            return this.var_20;
        }

        public function dispose(): void {
            this.var_20 = null;
        }
    }
}
