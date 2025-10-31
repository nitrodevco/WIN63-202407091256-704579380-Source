package com.sulake.habbo.communication.messages.parser.notifications {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1657

    [SecureSWF(rename="true")]
    public class PetLevelNotificationEventParser implements IMessageParser {

        public function PetLevelNotificationEventParser() {
            super();
        }
        private var var_393: int;
        private var var_970: String;
        private var var_360: int;
        private var var_145: class_1657;

        public function get petId(): int {
            return var_393;
        }

        public function get petName(): String {
            return var_970;
        }

        public function get level(): int {
            return var_360;
        }

        public function get figureData(): class_1657 {
            return var_145;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_393 = param1.readInteger();
            var_970 = param1.readString();
            var_360 = param1.readInteger();
            var_145 = new class_1657(param1);
            return true;
        }
    }
}
