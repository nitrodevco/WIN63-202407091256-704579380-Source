package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1225 implements IMessageParser {

        public function class_1225() {
            super();
        }
        private var var_393: int;
        private var var_360: int;

        private var var_1100: int;

        private var var_1365: int;

        private var var_883: int;

        private var var_1428: int;

        private var var_953: int;

        private var var_1216: int;

        private var var_1177: int;

        private var var_1196: int;

        private var var_876: int;
        private var var_1427: int;
        private var var_1204: int;
        private var var_1116: Boolean;
        private var var_768: Boolean;
        private var var_786: Boolean;
        private var var_1002: Boolean;
        private var var_910: Boolean;
        private var var_1308: int;
        private var var_800: int;
        private var var_1147: int;
        private var var_581: Array;
        private var var_1280: int;
        private var var_806: int;
        private var var_807: Boolean;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        private var _ownerName: String;

        public function get ownerName(): String {
            return _ownerName;
        }

        public function get petId(): int {
            return var_393;
        }

        public function get level(): int {
            return var_360;
        }

        public function get maxLevel(): int {
            return var_1100;
        }

        public function get experience(): int {
            return var_1365;
        }

        public function get energy(): int {
            return var_883;
        }

        public function get nutrition(): int {
            return var_1428;
        }

        public function get experienceRequiredToLevel(): int {
            return var_953;
        }

        public function get maxEnergy(): int {
            return var_1216;
        }

        public function get maxNutrition(): int {
            return var_1177;
        }

        public function get respect(): int {
            return var_1196;
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function get age(): int {
            return var_1427;
        }

        public function get breedId(): int {
            return var_1204;
        }

        public function get hasFreeSaddle(): Boolean {
            return var_1116;
        }

        public function get isRiding(): Boolean {
            return var_768;
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

        public function get maxWellBeingSeconds(): int {
            return var_1308;
        }

        public function get remainingWellBeingSeconds(): int {
            return var_800;
        }

        public function get remainingGrowingSeconds(): int {
            return var_1147;
        }

        public function get skillTresholds(): Array {
            return var_581;
        }

        public function get accessRights(): int {
            return var_1280;
        }

        public function get rarityLevel(): int {
            return var_806;
        }

        public function get hasBreedingPermission(): Boolean {
            return var_807;
        }

        public function flush(): Boolean {
            var_393 = -1;
            var_581 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            if (param1 == null) {
                return false;
            }
            var_393 = param1.readInteger();
            _name = param1.readString();
            var_360 = param1.readInteger();
            var_1100 = param1.readInteger();
            var_1365 = param1.readInteger();
            var_953 = param1.readInteger();
            var_883 = param1.readInteger();
            var_1216 = param1.readInteger();
            var_1428 = param1.readInteger();
            var_1177 = param1.readInteger();
            var_1196 = param1.readInteger();
            var_876 = param1.readInteger();
            var_1427 = param1.readInteger();
            _ownerName = param1.readString();
            var_1204 = param1.readInteger();
            var_1116 = param1.readBoolean();
            var_768 = param1.readBoolean();
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_581.push(param1.readInteger());
                _loc2_++;
            }
            var_581.sort(16);
            var_1280 = param1.readInteger();
            var_786 = param1.readBoolean();
            var_1002 = param1.readBoolean();
            var_910 = param1.readBoolean();
            var_806 = param1.readInteger();
            var_1308 = param1.readInteger();
            var_800 = param1.readInteger();
            var_1147 = param1.readInteger();
            var_807 = param1.readBoolean();
            return true;
        }
    }
}
