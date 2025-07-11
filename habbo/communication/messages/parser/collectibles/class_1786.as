package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1786 {

        public function class_1786(param1: IMessageDataWrapper) {
            var _loc2_: int = 0;
            super();
            var_1005 = param1.readShort();
            var_793 = param1.readString();
            var_367 = param1.readInteger();
            _amount = param1.readInteger();
            _petFigureString = param1.readString();
            var_719 = new Vector.<int>();
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_719.push(param1.readInteger());
                _loc2_++;
            }
            var_394 = param1.readString();
            var_1349 = param1.readString();
        }
        private var var_1005: int;
        private var var_793: String;
        private var var_367: int;
        private var var_719: Vector.<int>;
        private var var_394: String;
        private var var_1349: String;

        private var _amount: int;

        public function get amount(): int {
            return _amount;
        }

        private var _petFigureString: String;

        public function get petFigureString(): String {
            return _petFigureString;
        }

        public function get productTypeId(): int {
            return var_1005;
        }

        public function get itemTypeId(): String {
            return var_793;
        }

        public function get score(): int {
            return var_367;
        }

        public function get figureSetIds(): Vector.<int> {
            return var_719;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get rarity(): String {
            return var_1349;
        }
    }
}
