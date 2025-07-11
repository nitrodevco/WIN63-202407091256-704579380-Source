package com.sulake.habbo.communication.messages.outgoing.roomsettings {
    [SecureSWF(rename="true")]
    public class class_1455 {

        public function class_1455() {
            super();
        }
        private var var_369: int;
        private var var_363: String;

        private var var_1194: int;

        private var var_937: String;

        private var var_634: int;

        private var var_1242: int;

        private var var_320: Array;

        private var var_726: Array;

        private var var_870: int;

        private var var_1138: Boolean;

        private var var_1007: Boolean;

        private var var_1226: Boolean;

        private var var_1490: Boolean;
        private var var_1309: int;
        private var var_765: int;
        private var var_803: int;
        private var var_1466: int;
        private var var_990: int;
        private var var_1093: int;
        private var var_851: int;
        private var var_1261: int;

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

        public function get password(): String {
            return var_937;
        }

        public function set password(param1: String): void {
            var_937 = param1;
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

        public function get tags(): Array {
            return var_320;
        }

        public function set tags(param1: Array): void {
            var_320 = param1;
        }

        public function get controllers(): Array {
            return var_726;
        }

        public function set controllers(param1: Array): void {
            var_726 = param1;
        }

        public function get whoCanMute(): int {
            return var_1309;
        }

        public function set whoCanMute(param1: int): void {
            var_1309 = param1;
        }

        public function get whoCanKick(): int {
            return var_765;
        }

        public function set whoCanKick(param1: int): void {
            var_765 = param1;
        }

        public function get whoCanBan(): int {
            return var_803;
        }

        public function set whoCanBan(param1: int): void {
            var_803 = param1;
        }

        public function get chatMode(): int {
            return var_1466;
        }

        public function set chatMode(param1: int): void {
            var_1466 = param1;
        }

        public function get chatBubbleSize(): int {
            return var_990;
        }

        public function set chatBubbleSize(param1: int): void {
            var_990 = param1;
        }

        public function get chatScrollUpFrequency(): int {
            return var_1093;
        }

        public function set chatScrollUpFrequency(param1: int): void {
            var_1093 = param1;
        }

        public function get chatFullHearRange(): int {
            return var_851;
        }

        public function set chatFullHearRange(param1: int): void {
            var_851 = param1;
        }

        public function get chatFloodSensitivity(): int {
            return var_1261;
        }

        public function set chatFloodSensitivity(param1: int): void {
            var_1261 = param1;
        }

        public function get allowNavigatorDynCats(): Boolean {
            return var_1490;
        }

        public function set allowNavigatorDynCats(param1: Boolean): void {
            var_1490 = param1;
        }
    }
}
