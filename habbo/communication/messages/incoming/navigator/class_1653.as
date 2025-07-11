package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1653 implements IDisposable {

        public static const const_301: int = 1;

        public static const const_103: int = 2;

        public static const const_37: int = 4;

        public function class_1653(param1: IMessageDataWrapper) {
            super();
            _index = param1.readInteger();
            var_1492 = param1.readString();
            var_1220 = param1.readString();
            var_1008 = param1.readInteger() == 1;
            var_1322 = param1.readString();
            var_1145 = param1.readString();
            var_1223 = param1.readInteger();
            var_554 = param1.readInteger();
            var_329 = param1.readInteger();
            if (var_329 == 1) {
                var_881 = param1.readString();
            } else if (var_329 == 2) {
                var_242 = new class_1675(param1);
            } else {
                _open = param1.readBoolean();
            }
        }
        private var var_1492: String;

        private var var_1220: String;

        private var var_1008: Boolean;

        private var var_1322: String;

        private var var_1145: String;

        private var var_1223: int;

        private var var_554: int;

        private var var_329: int;

        private var var_881: String;

        private var var_242: class_1675;

        private var _index: int;

        public function get index(): int {
            return _index;
        }

        private var _open: Boolean;

        public function get open(): Boolean {
            return _open;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get type(): int {
            return var_329;
        }

        public function get popupCaption(): String {
            return var_1492;
        }

        public function get popupDesc(): String {
            return var_1220;
        }

        public function get showDetails(): Boolean {
            return var_1008;
        }

        public function get picText(): String {
            return var_1322;
        }

        public function get picRef(): String {
            return var_1145;
        }

        public function get folderId(): int {
            return var_1223;
        }

        public function get tag(): String {
            return var_881;
        }

        public function get userCount(): int {
            return var_554;
        }

        public function get guestRoomData(): class_1675 {
            return var_242;
        }

        public function get maxUsers(): int {
            if (this.type == 1) {
                return 0;
            }
            if (this.type == 2) {
                return this.var_242.maxUserCount;
            }
            return 0;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            if (this.var_242 != null) {
                this.var_242.dispose();
                this.var_242 = null;
            }
        }

        public function toggleOpen(): void {
            _open = !_open;
        }
    }
}
