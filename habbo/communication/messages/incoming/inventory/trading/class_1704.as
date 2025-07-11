package com.sulake.habbo.communication.messages.incoming.inventory.trading {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_1703
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1642
    import com.sulake.habbo.room.IStuffData

    import flash.utils.getTimer

    [SecureSWF(rename="true")]
    public class class_1704 implements class_1703 {

        public function class_1704(param1: IMessageDataWrapper) {
            super();
            var_517 = param1.readInteger();
            var_125 = param1.readString().toUpperCase();
            var_930 = param1.readInteger();
            var_793 = param1.readInteger();
            var_638 = param1.readInteger();
            var_854 = param1.readBoolean();
            var_1091 = class_1642.parseStuffData(param1);
            var_583 = -1;
            var_1234 = getTimer();
            var_1097 = false;
            var_1362 = param1.readInteger();
            _creationMonth = param1.readInteger();
            var_1042 = param1.readInteger();
            var_724 = itemType == "S" ? param1.readInteger() : -1;
            _flatId = -1;
            var_540 = false;
            var_801 = var_125 == "I";
        }
        private var var_1234: int;
        private var var_801: Boolean;
        private var var_517: int;
        private var var_125: String;
        private var var_930: int;
        private var var_793: int;
        private var var_638: int;
        private var var_1091: IStuffData;
        private var var_724: int;
        private var var_583: int;
        private var var_1362: int;
        private var var_1042: int;

        private var var_854: Boolean;

        private var var_606: int;
        private var var_540: Boolean;
        private var var_1097: Boolean;

        private var _creationMonth: int;

        public function get creationMonth(): int {
            return _creationMonth;
        }

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function get itemId(): int {
            return var_517;
        }

        public function get itemType(): String {
            return var_125;
        }

        public function get roomItemId(): int {
            return var_930;
        }

        public function get itemTypeId(): int {
            return var_793;
        }

        public function get category(): int {
            return var_638;
        }

        public function get stuffData(): IStuffData {
            return var_1091;
        }

        public function get extra(): int {
            return var_724;
        }

        public function get secondsToExpiration(): int {
            return var_583;
        }

        public function get creationDay(): int {
            return var_1362;
        }

        public function get creationYear(): int {
            return var_1042;
        }

        public function get isGroupable(): Boolean {
            return var_854;
        }

        public function get songId(): int {
            return var_724;
        }

        public function get isRented(): Boolean {
            return var_540;
        }

        public function get isWallItem(): Boolean {
            return var_801;
        }

        public function get hasRentPeriodStarted(): Boolean {
            return var_1097;
        }

        public function get expirationTimeStamp(): int {
            return var_1234;
        }

        public function get isRecyclable(): Boolean {
            return true;
        }

        public function get isTradeable(): Boolean {
            return true;
        }

        public function get isSellable(): Boolean {
            return true;
        }

        public function get slotId(): String {
            return null;
        }

        public function get isExternalImageFurni(): Boolean {
            return var_125.indexOf("external_image") != -1;
        }
    }
}
