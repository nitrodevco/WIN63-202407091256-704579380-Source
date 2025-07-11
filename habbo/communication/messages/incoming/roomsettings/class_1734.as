package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1734 implements class_1733 {

        public function class_1734(param1: IMessageDataWrapper) {
            super();
            this.var_418 = param1.readInteger();
            this._userName = param1.readString();
        }
        private var var_418: int;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        private var _selected: Boolean;

        public function get selected(): Boolean {
            return _selected;
        }

        public function set selected(param1: Boolean): void {
            _selected = param1;
        }

        public function get userId(): int {
            return var_418;
        }
    }
}
