package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1679 {

        public function class_1679(param1: IMessageDataWrapper) {
            super();
            var_280 = param1.readInteger();
            _name = param1.readString();
            var_145 = new class_1657(param1);
            var_360 = param1.readInteger();
        }
        private var var_280: int;
        private var var_145: class_1657;

        private var var_360: int;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get id(): int {
            return var_280;
        }

        public function get typeId(): int {
            return var_145.typeId;
        }

        public function get paletteId(): int {
            return var_145.paletteId;
        }

        public function get color(): String {
            return var_145.color;
        }

        public function get breedId(): int {
            return var_145.breedId;
        }

        public function get customPartCount(): int {
            return var_145.customPartCount;
        }

        public function get figureString(): String {
            return var_145.figureString;
        }

        public function get figureData(): class_1657 {
            return var_145;
        }

        public function get level(): int {
            return var_360;
        }
    }
}
