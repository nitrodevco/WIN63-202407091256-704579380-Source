package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1727 implements IDisposable, class_1662 {

        public function class_1727(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_320 = [];
            super();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_320.push(new class_1767(param1));
                _loc3_++;
            }
        }
        private var var_320: Array;

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get tags(): Array {
            return var_320;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            this.var_320 = null;
        }
    }
}
