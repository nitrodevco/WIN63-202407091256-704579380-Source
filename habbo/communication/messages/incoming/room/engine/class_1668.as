package com.sulake.habbo.communication.messages.incoming.room.engine {
    [SecureSWF(rename="true")]
    public class class_1668 {

        public static const const_22: String = "M";

        public static const const_306: String = "F";

        public function class_1668(param1: int) {
            super();
            var_871 = param1;
        }
        private var var_871: int = 0;
        private var var_31: Number = 0;
        private var var_28: Number = 0;
        private var var_30: Number = 0;
        private var var_643: int = 0;
        private var var_1347: int = 0;

        private var var_139: String = "";

        private var var_426: String = "";

        private var var_1435: String = "";
        private var var_1241: int = 0;
        private var var_860: String = "";
        private var var_622: String = "";
        private var var_876: int = 0;
        private var var_806: int;
        private var var_887: Boolean;
        private var var_768: Boolean;
        private var var_786: Boolean;
        private var var_1002: Boolean;
        private var var_910: Boolean;
        private var var_807: Boolean;
        private var var_1411: int = 0;
        private var var_1115: String = "";
        private var var_976: Boolean;
        private var var_25: Boolean = false;

        private var _name: String = "";

        public function get name(): String {
            return _name;
        }

        public function set name(param1: String): void {
            if (!var_25) {
                _name = param1;
            }
        }

        private var _achievementScore: int;

        public function get achievementScore(): int {
            return _achievementScore;
        }

        public function set achievementScore(param1: int): void {
            if (!var_25) {
                _achievementScore = param1;
            }
        }

        private var _groupStatus: int = 0;

        public function get groupStatus(): int {
            return _groupStatus;
        }

        public function set groupStatus(param1: int): void {
            if (!var_25) {
                _groupStatus = param1;
            }
        }

        private var _groupName: String = "";

        public function get groupName(): String {
            return _groupName;
        }

        public function set groupName(param1: String): void {
            if (!var_25) {
                _groupName = param1;
            }
        }

        private var _ownerName: String;

        public function get ownerName(): String {
            return _ownerName;
        }

        public function set ownerName(param1: String): void {
            if (!var_25) {
                _ownerName = param1;
            }
        }

        private var _botSkills: Array;

        public function get botSkills(): Array {
            return _botSkills;
        }

        public function set botSkills(param1: Array): void {
            _botSkills = param1;
        }

        public function get roomIndex(): int {
            return var_871;
        }

        public function get x(): Number {
            return var_31;
        }

        public function set x(param1: Number): void {
            if (!var_25) {
                var_31 = param1;
            }
        }

        public function get y(): Number {
            return var_28;
        }

        public function set y(param1: Number): void {
            if (!var_25) {
                var_28 = param1;
            }
        }

        public function get z(): Number {
            return var_30;
        }

        public function set z(param1: Number): void {
            if (!var_25) {
                var_30 = param1;
            }
        }

        public function get dir(): int {
            return var_643;
        }

        public function set dir(param1: int): void {
            if (!var_25) {
                var_643 = param1;
            }
        }

        public function get userType(): int {
            return var_1347;
        }

        public function set userType(param1: int): void {
            if (!var_25) {
                var_1347 = param1;
            }
        }

        public function get sex(): String {
            return var_139;
        }

        public function set sex(param1: String): void {
            if (!var_25) {
                var_139 = param1;
            }
        }

        public function get figure(): String {
            return var_426;
        }

        public function set figure(param1: String): void {
            if (!var_25) {
                var_426 = param1;
            }
        }

        public function get custom(): String {
            return var_1435;
        }

        public function set custom(param1: String): void {
            if (!var_25) {
                var_1435 = param1;
            }
        }

        public function get webID(): int {
            return var_1241;
        }

        public function set webID(param1: int): void {
            if (!var_25) {
                var_1241 = param1;
            }
        }

        public function get groupID(): String {
            return var_860;
        }

        public function set groupID(param1: String): void {
            if (!var_25) {
                var_860 = param1;
            }
        }

        public function get subType(): String {
            return var_622;
        }

        public function set subType(param1: String): void {
            if (!var_25) {
                var_622 = param1;
            }
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function set ownerId(param1: int): void {
            if (!var_25) {
                var_876 = param1;
            }
        }

        public function get rarityLevel(): int {
            return var_806;
        }

        public function set rarityLevel(param1: int): void {
            if (!var_25) {
                var_806 = param1;
            }
        }

        public function get hasSaddle(): Boolean {
            return var_887;
        }

        public function set hasSaddle(param1: Boolean): void {
            if (!var_25) {
                var_887 = param1;
            }
        }

        public function get isRiding(): Boolean {
            return var_768;
        }

        public function set isRiding(param1: Boolean): void {
            if (!var_25) {
                var_768 = param1;
            }
        }

        public function get canBreed(): Boolean {
            return var_786;
        }

        public function set canBreed(param1: Boolean): void {
            if (!var_25) {
                var_786 = param1;
            }
        }

        public function get canHarvest(): Boolean {
            return var_1002;
        }

        public function set canHarvest(param1: Boolean): void {
            if (!var_25) {
                var_1002 = param1;
            }
        }

        public function get canRevive(): Boolean {
            return var_910;
        }

        public function set canRevive(param1: Boolean): void {
            if (!var_25) {
                var_910 = param1;
            }
        }

        public function get hasBreedingPermission(): Boolean {
            return var_807;
        }

        public function set hasBreedingPermission(param1: Boolean): void {
            if (!var_25) {
                var_807 = param1;
            }
        }

        public function get petLevel(): int {
            return var_1411;
        }

        public function set petLevel(param1: int): void {
            if (!var_25) {
                var_1411 = param1;
            }
        }

        public function get petPosture(): String {
            return var_1115;
        }

        public function set petPosture(param1: String): void {
            if (!var_25) {
                var_1115 = param1;
            }
        }

        public function get isModerator(): Boolean {
            return var_976;
        }

        public function set isModerator(param1: Boolean): void {
            if (!var_25) {
                var_976 = param1;
            }
        }

        public function setReadOnly(): void {
            var_25 = true;
        }
    }
}
