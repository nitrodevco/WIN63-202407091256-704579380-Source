    package com.sulake.habbo.room.object.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.IRoomObjectModelController

    import adobe.serialization.json.JSONDecoder

    public class StuffDataBase implements IStuffData {

        public function StuffDataBase() {
            super();
        }
        private var var_626: int;
        private var var_188: int = 0;

        private var _uniqueSerialNumber: int = 0;

        public function get uniqueSerialNumber(): int {
            return _uniqueSerialNumber;
        }

        public function set uniqueSerialNumber(param1: int): void {
            _uniqueSerialNumber = param1;
        }

        public function set flags(param1: int): void {
            var_626 = param1;
        }

        public function get uniqueSeriesSize(): int {
            return var_188;
        }

        public function set uniqueSeriesSize(param1: int): void {
            var_188 = param1;
        }

        public function get rarityLevel(): int {
            return -1;
        }

        public function get state(): int {
            var _loc1_: Number = Number(getLegacyString());
            return isNaN(_loc1_) ? -1 : int(_loc1_);
        }

        public function initializeFromIncomingMessage(param1: IMessageDataWrapper): void {
            if ((var_626 & 256) > 0) {
                _uniqueSerialNumber = param1.readInteger();
                var_188 = param1.readInteger();
            }
        }

        public function initializeFromRoomObjectModel(param1: IRoomObjectModel): void {
            _uniqueSerialNumber = param1.getNumber("furniture_unique_serial_number");
            var_188 = param1.getNumber("furniture_unique_edition_size");
        }

        public function writeRoomObjectModel(param1: IRoomObjectModelController): void {
            param1.setNumber("furniture_unique_serial_number", _uniqueSerialNumber);
            param1.setNumber("furniture_unique_edition_size", var_188);
        }

        public function getLegacyString(): String {
            return "";
        }

        public function compare(param1: IStuffData): Boolean {
            return false;
        }

        public function getJSONValue(param1: String): String {
            var _loc2_: * = null;
            try {
                return String(new JSONDecoder(getLegacyString(), true).getValue()[param1]);
            } catch (error: Error) {
                var _loc5_: String = "";
            }
            return _loc5_;
        }
    }
}
