package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1661 {

        public function class_1661(param1: IMessageDataWrapper) {
            super();
            var_793 = param1.readInteger();
            _startTime = param1.readInteger();
            _endTime = param1.readInteger();
            var_1502 = param1.readBoolean();
            var_886 = param1.readInteger();
            var_1299 = param1.readBoolean();
            var _loc2_: int = param1.readShort();
            switch (_loc2_) {
                case 0:
                    var_125 = "s";
                    break;
                case 1:
                    var_125 = "i";
                    break;
                case 2:
                    var_125 = "cl";
                    break;
                default:
                    var_125 = "s";
            }
        }
        private var var_793: int;
        private var var_1502: Boolean;
        private var var_886: int;
        private var var_1299: Boolean;
        private var var_125: String;

        private var _startTime: int;

        public function get startTime(): int {
            return _startTime;
        }

        private var _endTime: int;

        public function get endTime(): int {
            return _endTime;
        }

        public function get itemTypeId(): int {
            return var_793;
        }

        public function get regionLocked(): Boolean {
            return var_1502;
        }

        public function get price(): int {
            return var_886;
        }

        public function get limitedEdition(): Boolean {
            return var_1299;
        }

        public function get itemType(): String {
            return var_125;
        }
    }
}
