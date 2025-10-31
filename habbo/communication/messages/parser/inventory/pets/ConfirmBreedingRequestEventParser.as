package com.sulake.habbo.communication.messages.parser.inventory.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_1683
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_1705

    [SecureSWF(rename="true")]
    public class ConfirmBreedingRequestEventParser implements IMessageParser {

        public function ConfirmBreedingRequestEventParser() {
            super();
        }
        private var var_596: int;
        private var var_446: Array;
        private var var_1248: int;

        private var _pet1: class_1683;

        public function get pet1(): class_1683 {
            return _pet1;
        }

        private var _pet2: class_1683;

        public function get pet2(): class_1683 {
            return _pet2;
        }

        public function get nestId(): int {
            return var_596;
        }

        public function get rarityCategories(): Array {
            return var_446;
        }

        public function get resultPetType(): int {
            return var_1248;
        }

        public function flush(): Boolean {
            var_596 = 0;
            if (_pet1) {
                _pet1.dispose();
                _pet1 = null;
            }
            if (_pet2) {
                _pet2.dispose();
                _pet2 = null;
            }
            for each(var _loc1_ in var_446) {
                _loc1_.dispose();
            }
            var_446 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_596 = param1.readInteger();
            _pet1 = new class_1683(param1);
            _pet2 = new class_1683(param1);
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_446.push(new class_1705(param1));
                _loc2_++;
            }
            var_1248 = param1.readInteger();
            return true;
        }
    }
}
