package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1675

    [SecureSWF(rename="true")]
    public class class_1770 {

        public static const const_255: int = 0;

        public static const const_164: int = 1;

        public static const const_62: int = 2;

        public function class_1770(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            _guestRooms = new Vector.<class_1675>(0);
            super();
            var_1066 = param1.readString();
            _text = param1.readString();
            var_1130 = param1.readInteger();
            var_1342 = param1.readBoolean();
            var_425 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _guestRooms.push(new class_1675(param1));
                _loc3_++;
            }
        }
        private var var_1066: String;
        private var var_1130: int;

        private var var_1342: Boolean;

        private var var_425: int;

        private var _text: String;

        public function get text(): String {
            return _text;
        }

        private var _guestRooms: Vector.<class_1675>;

        public function get guestRooms(): Vector.<class_1675> {
            return _guestRooms;
        }

        public function get searchCode(): String {
            return var_1066;
        }

        public function get actionAllowed(): int {
            return var_1130;
        }

        public function get forceClosed(): Boolean {
            return var_1342;
        }

        public function get viewMode(): int {
            return var_425;
        }

        public function set viewMode(param1: int): void {
            var_425 = param1;
        }

        public function findGuestRoom(param1: int): class_1675 {
            for each(var _loc2_ in _guestRooms) {
                if (_loc2_.flatId == param1) {
                    return _loc2_;
                }
            }
            return null;
        }
    }
}
