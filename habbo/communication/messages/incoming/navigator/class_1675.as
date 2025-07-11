package com.sulake.habbo.communication.messages.incoming.navigator {
   import com.sulake.core.communication.messages.IMessageDataWrapper
   import com.sulake.core.runtime.IDisposable

   [SecureSWF(rename="true")]
    public class class_1675 implements IDisposable {

        private const const_370: int = 1;

        private const const_331: int = 2;

        private const const_91: int = 4;

        private const const_348: int = 8;

        private const const_310: int = 16;

        private const const_32: int = 32;

        public function class_1675(param1: IMessageDataWrapper) {
            var _loc4_: int = 0;
            var _loc5_: String = null;
            var_320 = [];
            super();
            _flatId = param1.readInteger();
            _roomName = param1.readString();
            var_876 = param1.readInteger();
            _ownerName = param1.readString();
            var_1194 = param1.readInteger();
            var_554 = param1.readInteger();
            var_853 = param1.readInteger();
            var_363 = param1.readString();
            var_870 = param1.readInteger();
            var_367 = param1.readInteger();
            var_796 = param1.readInteger();
            var_634 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc5_ = param1.readString();
                var_320.push(_loc5_);
                _loc4_++;
            }
            var _loc2_: int = param1.readInteger();
            if ((_loc2_ & 1) > 0) {
                var_1107 = param1.readString();
            }
            if ((_loc2_ & 2) > 0) {
                var_903 = param1.readInteger();
                _groupName = param1.readString();
                var_1187 = param1.readString();
            }
            if ((_loc2_ & 4) > 0) {
                var_1410 = param1.readString();
                var_1464 = param1.readString();
                var_1009 = param1.readInteger();
            }
            var_1174 = (_loc2_ & 8) > 0;
            var_1138 = (_loc2_ & 16) > 0;
            var_1193 = (_loc2_ & 32) > 0;
            var_730 = new class_1782(null);
            var_730.setDefaults();
        }
        private var var_1174: Boolean;
        private var var_876: int;
        private var var_1194: int;
        private var var_554: int;
        private var var_853: int;
        private var var_363: String;
        private var var_870: int;
        private var var_367: int;
        private var var_796: int;
        private var var_634: int;
        private var var_1623: int;
        private var var_903: int = 0;
        private var var_1187: String = "";
        private var var_320: Array;
        private var var_730: class_1782;
        private var var_1138: Boolean;
        private var var_1193: Boolean;
        private var var_1410: String = "";
        private var var_1464: String = "";
        private var var_1009: int = 0;
        private var var_1182: Boolean;
        private var var_1366: Boolean;
        private var var_1107: String = null;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        private var _roomName: String;

        public function get roomName(): String {
            return _roomName;
        }

        public function set roomName(param1: String): void {
            _roomName = param1;
        }

        private var _ownerName: String;

        public function get ownerName(): String {
            return _ownerName;
        }

        private var _groupName: String = "";

        public function get groupName(): String {
            return _groupName;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get showOwner(): Boolean {
            return var_1174;
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function get doorMode(): int {
            return var_1194;
        }

        public function get userCount(): int {
            return var_554;
        }

        public function get maxUserCount(): int {
            return var_853;
        }

        public function get description(): String {
            return var_363;
        }

        public function get tradeMode(): int {
            return var_870;
        }

        public function get score(): int {
            return var_367;
        }

        public function get ranking(): int {
            return var_796;
        }

        public function get categoryId(): int {
            return var_634;
        }

        public function get habboGroupId(): int {
            return var_903;
        }

        public function get groupBadgeCode(): String {
            return var_1187;
        }

        public function get tags(): Array {
            return var_320;
        }

        public function get thumbnail(): class_1782 {
            return var_730;
        }

        public function get allowPets(): Boolean {
            return var_1138;
        }

        public function get displayRoomEntryAd(): Boolean {
            return var_1193;
        }

        public function get roomAdName(): String {
            return var_1410;
        }

        public function get roomAdDescription(): String {
            return var_1464;
        }

        public function get roomAdExpiresInMin(): int {
            return var_1009;
        }

        public function get allInRoomMuted(): Boolean {
            return var_1182;
        }

        public function set allInRoomMuted(param1: Boolean): void {
            var_1182 = param1;
        }

        public function get officialRoomPicRef(): String {
            return var_1107;
        }

        public function get canMute(): Boolean {
            return var_1366;
        }

        public function set canMute(param1: Boolean): void {
            var_1366 = param1;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            this.var_320 = null;
        }
    }
}
