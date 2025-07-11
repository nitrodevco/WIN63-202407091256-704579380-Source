package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1657 {

        public function class_1657(param1: IMessageDataWrapper) {
            var _loc2_: int = 0;
            super();
            var_1311 = param1.readInteger();
            var_907 = param1.readInteger();
            _color = param1.readString();
            var_1204 = param1.readInteger();
            var_335 = [];
            var_691 = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < var_691) {
                var_335.push(param1.readInteger());
                var_335.push(param1.readInteger());
                var_335.push(param1.readInteger());
                _loc2_++;
            }
        }
        private var var_1311: int;
        private var var_907: int;
        private var var_1204: int;

        private var var_691: int;

        private var var_335: Array;

        private var _color: String;

        public function get color(): String {
            return _color;
        }

        public function get typeId(): int {
            return var_1311;
        }

        public function get paletteId(): int {
            return var_907;
        }

        public function get breedId(): int {
            return var_1204;
        }

        public function get figureString(): String {
            var _loc2_: String = typeId + " " + paletteId + " " + color;
            _loc2_ += " " + customPartCount;
            for each(var _loc1_ in customParts) {
                _loc2_ += " " + _loc1_;
            }
            return _loc2_;
        }

        public function get customParts(): Array {
            return var_335;
        }

        public function get customPartCount(): int {
            return var_691;
        }
    }
}
