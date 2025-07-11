package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.runtime.IDisposable;

    [SecureSWF(rename="true")]
    public class class_1769 implements IDisposable {

        public function class_1769(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_320 = [];
            super();
            var_1166 = param1.readBoolean();
            if (!exists) {
                return;
            }
            _name = param1.readString();
            _desc = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_320.push(param1.readString());
                _loc3_++;
            }
        }
        private var var_1166: Boolean;
        private var var_320: Array;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        private var _desc: String;

        public function get desc(): String {
            return _desc;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get tags(): Array {
            return var_320;
        }

        public function get exists(): Boolean {
            return var_1166;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            var_320 = null;
        }
    }
}
