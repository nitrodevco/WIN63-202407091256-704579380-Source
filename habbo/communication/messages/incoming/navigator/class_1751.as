package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1751 implements IDisposable, class_1662 {

        public function class_1751(param1: IMessageDataWrapper) {
            var _loc5_: int = 0;
            var _loc6_: int = 0;
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            var_642 = new Map();
            var_415 = new Map();
            super();
            var _loc4_: int = param1.readInteger();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc6_ = param1.readInteger();
                _loc3_ = param1.readInteger();
                _loc2_ = param1.readInteger();
                var_642.add(_loc6_, _loc3_);
                var_415.add(_loc6_, _loc2_);
                _loc5_++;
            }
        }
        private var var_642: Map;
        private var var_415: Map;

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get categoryToCurrentUserCountMap(): Map {
            return var_642;
        }

        public function get categoryToMaxUserCountMap(): Map {
            return var_415;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            this.var_642 = null;
            this.var_415 = null;
        }
    }
}
