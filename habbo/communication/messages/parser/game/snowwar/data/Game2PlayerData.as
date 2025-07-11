package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    public class Game2PlayerData implements IDisposable {

        public function Game2PlayerData() {
            super();
        }
        private var var_694: int;
        private var var_129: String;
        private var var_893: int;
        private var var_318: Boolean = false;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        private var _figureString: String;

        public function get figureString(): String {
            return _figureString;
        }

        public function get disposed(): Boolean {
            return var_318;
        }

        public function get referenceId(): int {
            return var_694;
        }

        public function get gender(): String {
            return var_129;
        }

        public function get teamId(): int {
            return var_893;
        }

        public function get isDisposed(): Boolean {
            return var_318;
        }

        public function dispose(): void {
            _userName = null;
            _figureString = null;
            var_318 = true;
        }

        public function parse(param1: IMessageDataWrapper): void {
            var_694 = param1.readInteger();
            _userName = param1.readString();
            _figureString = param1.readString();
            var_129 = param1.readString();
            var_893 = param1.readInteger();
        }

        public function toString(): String {
            return "[Game Player] " + var_694 + ": " + _userName;
        }
    }
}
