package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PetStatusUpdateEventParser implements IMessageParser {

        public function PetStatusUpdateEventParser() {
            super();
        }
        private var var_871: int;
        private var var_393: int;
        private var var_786: Boolean;
        private var var_1002: Boolean;
        private var var_910: Boolean;
        private var var_807: Boolean;

        public function get roomIndex(): int {
            return var_871;
        }

        public function get petId(): int {
            return var_393;
        }

        public function get canBreed(): Boolean {
            return var_786;
        }

        public function get canHarvest(): Boolean {
            return var_1002;
        }

        public function get canRevive(): Boolean {
            return var_910;
        }

        public function get hasBreedingPermission(): Boolean {
            return var_807;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_871 = param1.readInteger();
            var_393 = param1.readInteger();
            var_786 = param1.readBoolean();
            var_1002 = param1.readBoolean();
            var_910 = param1.readBoolean();
            var_807 = param1.readBoolean();
            return true;
        }
    }
}
