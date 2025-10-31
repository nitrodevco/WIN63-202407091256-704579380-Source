package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1679

    [SecureSWF(rename="true")]
    public class PetRespectNotificationEventParser implements IMessageParser {

        public static const const_150: int = 16;

        public function PetRespectNotificationEventParser() {
            super();
        }
        private var var_1196: int;
        private var var_1162: int;
        private var var_328: class_1679;

        public function get petOwnerId(): int {
            return var_1162;
        }

        public function get respect(): int {
            return var_1196;
        }

        public function get petData(): class_1679 {
            return var_328;
        }

        public function flush(): Boolean {
            var_328 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1196 = param1.readInteger();
            var_1162 = param1.readInteger();
            var_328 = new class_1679(param1);
            return true;
        }

        public function isTreat(): Boolean {
            return var_328.typeId == 16;
        }
    }
}
