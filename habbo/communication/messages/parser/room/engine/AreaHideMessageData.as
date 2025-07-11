package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class AreaHideMessageData {

        public function AreaHideMessageData(param1: IMessageDataWrapper) {
            super();
            var_603 = param1.readInteger();
            _on = param1.readBoolean();
            var_797 = param1.readInteger();
            var_1094 = param1.readInteger();
            _width = param1.readInteger();
            _length = param1.readInteger();
            var_787 = param1.readBoolean();
        }
        private var var_603: int;
        private var var_797: int;

        private var var_1094: int;
        private var var_787: Boolean;

        private var _on: Boolean;

        public function get on(): Boolean {
            return _on;
        }

        private var _width: int;

        public function get width(): int {
            return _width;
        }

        private var _length: int;

        public function get length(): int {
            return _length;
        }

        public function get furniId(): int {
            return var_603;
        }

        public function get rootX(): int {
            return var_797;
        }

        public function get rootY(): int {
            return var_1094;
        }

        public function get invert(): Boolean {
            return var_787;
        }
    }
}
