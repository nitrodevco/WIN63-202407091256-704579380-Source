package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1688 {

        public function class_1688(param1: IMessageDataWrapper) {
            super();
            var_280 = param1.readInteger();
            _color = parseInt(param1.readString(), 16);
        }
        private var var_280: int;

        private var _color: uint;

        public function get color(): uint {
            return _color;
        }

        public function get id(): int {
            return var_280;
        }

        public function get red(): int {
            return _color >> 16 & 255;
        }

        public function get green(): int {
            return _color >> 8 & 255;
        }

        public function get blue(): int {
            return _color >> 0 & 255;
        }
    }
}
