package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PetRespectFailedEventParser implements IMessageParser {

        public function PetRespectFailedEventParser() {
            super();
        }
        private var var_919: int;
        private var var_1439: int;

        public function get requiredDays(): int {
            return var_919;
        }

        public function get avatarAgeInDays(): int {
            return var_1439;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_919 = param1.readInteger();
            var_1439 = param1.readInteger();
            return true;
        }
    }
}
