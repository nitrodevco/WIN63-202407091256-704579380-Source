package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class class_1212 {

        private static function removeFromArray(param1: int, param2: Array): void {
            var _loc4_: int = 0;
            var _loc3_: class_1251 = null;
            while (_loc4_ < param2.length) {
                _loc3_ = param2[_loc4_];
                if (_loc3_.userId == param1) {
                    param2.splice(_loc4_, 1);
                } else {
                    _loc4_++;
                }
            }
        }

        public function class_1212(param1: IMessageDataWrapper) {
            var _loc4_: int = 0;
            var _loc3_: class_1251 = null;
            var_356 = new Dictionary();
            super();
            _groupId = param1.readInteger();
            _groupName = param1.readString();
            var_1180 = param1.readInteger();
            var_413 = param1.readString();
            var_761 = param1.readInteger();
            var_97 = [];
            var _loc2_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_ = new class_1251(param1);
                var_97.push(_loc3_);
                var_356[_loc3_.userId] = _loc3_;
                _loc4_++;
            }
            var_1477 = param1.readBoolean();
            var_749 = param1.readInteger();
            var_479 = param1.readInteger();
            var_982 = param1.readInteger();
            var_784 = param1.readString();
        }
        private var var_1180: int;

        private var var_413: String;

        private var var_761: int;

        private var var_97: Array;

        private var var_1477: Boolean;

        private var var_749: int;

        private var var_479: int;

        private var var_982: int;

        private var var_784: String;

        private var var_356: Dictionary;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _groupName: String;

        public function get groupName(): String {
            return _groupName;
        }

        public function get baseRoomId(): int {
            return var_1180;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function get totalEntries(): int {
            return var_761;
        }

        public function get pageSize(): int {
            return var_749;
        }

        public function get pageIndex(): int {
            return var_479;
        }

        public function get searchType(): int {
            return var_982;
        }

        public function get entries(): Array {
            return var_97;
        }

        public function get allowedToManage(): Boolean {
            return var_1477;
        }

        public function get userNameFilter(): String {
            return var_784;
        }

        public function get totalPages(): int {
            return Math.max(1, Math.ceil(var_761 / var_749));
        }

        public function update(param1: class_1251): void {
            var _loc3_: int = 0;
            var _loc2_: class_1251 = null;
            var_356[param1.userId] = param1;
            while (_loc3_ < var_97.length) {
                _loc2_ = var_97[_loc3_];
                if (_loc2_.userId == param1.userId) {
                    var_97[_loc3_] = param1;
                    return;
                }
                _loc3_++;
            }
            var_97.push(param1);
        }

        public function remove(param1: int): void {
            removeFromArray(param1, var_97);
            delete var_356[param1];
        }

        public function getUser(param1: int): class_1251 {
            return var_356[param1];
        }
    }
}
