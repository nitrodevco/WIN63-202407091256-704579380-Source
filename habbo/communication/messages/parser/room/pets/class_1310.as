package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1657

    [SecureSWF(rename="true")]
    public class class_1310 implements IMessageParser {

        public function class_1310() {
            super();
        }
        private var var_871: int;
        private var var_393: int;
        private var var_145: class_1657;
        private var var_887: Boolean;
        private var var_768: Boolean;

        public function get roomIndex(): int {
            return var_871;
        }

        public function get petId(): int {
            return var_393;
        }

        public function get figureData(): class_1657 {
            return var_145;
        }

        public function get hasSaddle(): Boolean {
            return var_887;
        }

        public function get isRiding(): Boolean {
            return var_768;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_871 = param1.readInteger();
            var_393 = param1.readInteger();
            var_145 = new class_1657(param1);
            var_887 = param1.readBoolean();
            var_768 = param1.readBoolean();
            return true;
        }
    }
}
