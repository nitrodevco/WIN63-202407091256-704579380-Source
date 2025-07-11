package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1749 implements IDisposable {

        public function class_1749(param1: IMessageDataWrapper) {
            super();
            _flatId = param1.readInteger();
            var_554 = param1.readInteger();
            var_1071 = param1.readBoolean();
            var_876 = param1.readInteger();
            _ownerName = param1.readString();
            var_244 = new class_1769(param1);
        }
        private var var_554: int;

        private var var_1071: Boolean;

        private var var_876: int;
        private var var_244: class_1769;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        private var _ownerName: String;

        public function get ownerName(): String {
            return _ownerName;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get userCount(): int {
            return var_554;
        }

        public function get ownerInRoom(): Boolean {
            return var_1071;
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function get room(): class_1769 {
            return var_244;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            if (var_244 != null) {
                var_244.dispose();
                var_244 = null;
            }
        }
    }
}
