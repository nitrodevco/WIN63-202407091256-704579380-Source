package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1742 implements IDisposable, class_1662 {

        public function class_1742(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            _rooms = [];
            super();
            var_982 = param1.readInteger();
            var_857 = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _rooms.push(new class_1675(param1));
                _loc3_++;
            }
            var _loc4_: Boolean;
            if (_loc4_ = param1.readBoolean()) {
                var_210 = new class_1653(param1);
            }
        }
        private var var_982: int;
        private var var_857: String;
        private var var_210: class_1653;

        private var _rooms: Array;

        public function get rooms(): Array {
            return _rooms;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get searchType(): int {
            return var_982;
        }

        public function get searchParam(): String {
            return var_857;
        }

        public function get ad(): class_1653 {
            return var_210;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            if (this._rooms != null) {
                for each(var _loc1_ in this._rooms) {
                    _loc1_.dispose();
                }
            }
            if (var_210 != null) {
                var_210.dispose();
                var_210 = null;
            }
            this._rooms = null;
        }
    }
}
