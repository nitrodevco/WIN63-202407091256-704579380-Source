package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1663 implements IDisposable, class_1662 {

        public function class_1663(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_97 = [];
            super();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_97.push(new class_1653(param1));
                _loc3_++;
            }
        }
        private var var_97: Array;

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get entries(): Array {
            return var_97;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            if (var_97 != null) {
                for each(var _loc1_ in var_97) {
                    _loc1_.dispose();
                }
            }
            var_97 = null;
        }
    }
}
