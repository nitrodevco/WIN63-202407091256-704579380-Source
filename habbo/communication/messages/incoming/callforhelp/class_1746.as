package com.sulake.habbo.communication.messages.incoming.callforhelp {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1743

    [SecureSWF(rename="true")]
    public class class_1746 implements class_1743, IDisposable {

        public function class_1746(param1: IMessageDataWrapper) {
            var _loc2_: int = 0;
            super();
            var_317 = new Vector.<class_1785>();
            _name = param1.readString();
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_317.push(new class_1785(param1));
                _loc2_++;
            }
        }
        private var var_317: Vector.<class_1785>;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get topics(): Vector.<class_1785> {
            return var_317;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            var_317 = null;
        }
    }
}
