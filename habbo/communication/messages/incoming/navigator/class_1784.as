package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1784 implements IDisposable {

        public function class_1784(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            _rooms = [];
            super();
            var_1078 = param1.readString();
            var_1212 = param1.readString();
            var _loc2_: int = param1.readInteger();
            var_236 = new class_1675(param1);
            _loc3_ = 1;
            while (_loc3_ < _loc2_) {
                _rooms.push(new class_1675(param1));
                _loc3_++;
            }
        }
        private var var_1078: String;
        private var var_1212: String;
        private var var_236: class_1675;
        private var var_1287: Boolean;

        private var _rooms: Array;

        public function get rooms(): Array {
            return _rooms;
        }

        private var _open: Boolean;

        public function get open(): Boolean {
            return _open;
        }

        public function set open(param1: Boolean): void {
            _open = param1;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get code(): String {
            return var_1078;
        }

        public function get leaderFigure(): String {
            return var_1212;
        }

        public function get bestRoom(): class_1675 {
            return var_236;
        }

        public function get figurePending(): Boolean {
            return var_1287;
        }

        public function set figurePending(param1: Boolean): void {
            var_1287 = param1;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            if (var_236) {
                var_236.dispose();
                var_236 = null;
            }
            for each(var _loc1_ in rooms) {
                _loc1_.dispose();
            }
            _rooms = null;
        }

        public function toggleOpen(): void {
            _open = !_open;
        }
    }
}
