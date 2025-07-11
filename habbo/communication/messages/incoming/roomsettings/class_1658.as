package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class class_1658 {

        public static const const_165: int = 0;

        public static const const_265: int = 1;

        public static const const_282: int = 2;

        public static const const_124: int = 3;

        public static const const_98: int = 4;

        public static const const_41: int = 0;

        public static const const_116: int = 1;

        public static const const_280: int = 2;

        public static function getDoorModeLocalizationKey(param1: int): String {
            switch (param1) {
                case 0:
                    return "${navigator.door.mode.open}";
                case 1:
                    return "${navigator.door.mode.closed}";
                case 2:
                    return "${navigator.door.mode.password}";
                case 3:
                    return "${navigator.door.mode.invisible}";
                case 4:
                    return "${navigator.door.mode.noobs_only}";
                default:
                    return "";
            }
        }

        public function class_1658() {
            super();
        }
        private var var_369: int;
        private var var_363: String;
        private var var_1194: int;
        private var var_634: int;
        private var var_1242: int;
        private var var_1405: int;
        private var var_320: Array;
        private var var_870: int;
        private var var_1138: Boolean;
        private var var_1007: Boolean;
        private var var_1226: Boolean;
        private var var_245: Dictionary;
        private var var_162: Array;
        private var var_1092: int;
        private var var_342: Dictionary;
        private var var_158: Array;
        private var var_454: class_1731;
        private var var_526: class_1732;
        private var var_954: Boolean;
        private var var_1351: Boolean;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function set name(param1: String): void {
            _name = param1;
        }

        private var _hideWalls: Boolean;

        public function get hideWalls(): Boolean {
            return _hideWalls;
        }

        public function set hideWalls(param1: Boolean): void {
            _hideWalls = param1;
        }

        private var _wallThickness: int;

        public function get wallThickness(): int {
            return _wallThickness;
        }

        public function set wallThickness(param1: int): void {
            _wallThickness = param1;
        }

        private var _floorThickness: int;

        public function get floorThickness(): int {
            return _floorThickness;
        }

        public function set floorThickness(param1: int): void {
            _floorThickness = param1;
        }

        public function get tradeMode(): int {
            return var_870;
        }

        public function set tradeMode(param1: int): void {
            var_870 = param1;
        }

        public function get allowPets(): Boolean {
            return var_1138;
        }

        public function set allowPets(param1: Boolean): void {
            var_1138 = param1;
        }

        public function get allowFoodConsume(): Boolean {
            return var_1007;
        }

        public function set allowFoodConsume(param1: Boolean): void {
            var_1007 = param1;
        }

        public function get allowWalkThrough(): Boolean {
            return var_1226;
        }

        public function set allowWalkThrough(param1: Boolean): void {
            var_1226 = param1;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function set roomId(param1: int): void {
            var_369 = param1;
        }

        public function get description(): String {
            return var_363;
        }

        public function set description(param1: String): void {
            var_363 = param1;
        }

        public function get doorMode(): int {
            return var_1194;
        }

        public function set doorMode(param1: int): void {
            var_1194 = param1;
        }

        public function get categoryId(): int {
            return var_634;
        }

        public function set categoryId(param1: int): void {
            var_634 = param1;
        }

        public function get maximumVisitors(): int {
            return var_1242;
        }

        public function set maximumVisitors(param1: int): void {
            var_1242 = param1;
        }

        public function get maximumVisitorsLimit(): int {
            return var_1405;
        }

        public function set maximumVisitorsLimit(param1: int): void {
            var_1405 = param1;
        }

        public function get tags(): Array {
            return var_320;
        }

        public function set tags(param1: Array): void {
            var_320 = param1;
        }

        public function get roomModerationSettings(): class_1731 {
            return var_454;
        }

        public function set roomModerationSettings(param1: class_1731): void {
            var_454 = param1;
        }

        public function get controllersById(): Dictionary {
            return var_245;
        }

        public function set controllersById(param1: Dictionary): void {
            var_245 = param1;
        }

        public function get controllerList(): Array {
            var _loc3_: int = 0;
            var _loc2_: class_1734 = null;
            if (var_162 == null) {
                var_162 = [];
                for (var _loc1_ in var_245) {
                    _loc3_ = int(_loc1_);
                    _loc2_ = var_245[_loc3_];
                    if (_loc2_ != null) {
                        var_162.push(_loc2_);
                    }
                }
                var_162.sortOn("userName", 1);
            }
            return var_162;
        }

        public function get highlightedUserId(): int {
            return var_1092;
        }

        public function get bannedUsersById(): Dictionary {
            return var_342;
        }

        public function get bannedUsersList(): Array {
            if (var_158 == null) {
                var_158 = [];
                for each(var _loc1_ in var_342) {
                    var_158.push(_loc1_);
                }
                var_158.sortOn("userName", 1);
            }
            return var_158;
        }

        public function get chatSettings(): class_1732 {
            return var_526;
        }

        public function set chatSettings(param1: class_1732): void {
            var_526 = param1;
        }

        public function get allowNavigatorDynamicCats(): Boolean {
            return var_954;
        }

        public function set allowNavigatorDynamicCats(param1: Boolean): void {
            var_954 = param1;
        }

        public function get hiddenByBc(): Boolean {
            return var_1351;
        }

        public function set hiddenByBc(param1: Boolean): void {
            var_1351 = param1;
        }

        public function setFlatController(param1: int, param2: class_1734): void {
            if (var_245 != null) {
                var_245[param1] = param2;
                var_162 = null;
                var_1092 = param1;
            }
        }

        public function setBannedUser(param1: int, param2: class_1748): void {
            if (var_342 == null) {
                var_342 = new Dictionary();
            } else {
                var_158 = null;
            }
            var_342[param1] = param2;
        }
    }
}
