package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.habbo.room.IStuffData
    import com.sulake.habbo.room.object.data.LegacyStuffData

    [SecureSWF(rename="true")]
    public class class_1765 {

        public function class_1765(param1: int) {
            var_47 = new LegacyStuffData();
            super();
            var_280 = param1;
        }
        private var var_280: int = 0;
        private var var_31: Number = 0;
        private var var_28: Number = 0;
        private var var_30: Number = 0;
        private var var_643: int = 0;
        private var var_943: int = 0;
        private var var_799: int = 0;
        private var var_1397: Number = 0;
        private var var_329: int = 0;
        private var var_724: int = -1;
        private var var_149: int = 0;
        private var var_47: IStuffData;
        private var var_1198: int;

        private var var_876: int = 0;
        private var var_1496: String = null;
        private var var_25: Boolean = false;
        private var var_1451: Boolean = false;

        private var _expiryTime: int = 0;

        public function get expiryTime(): int {
            return _expiryTime;
        }

        public function set expiryTime(param1: int): void {
            if (!var_25) {
                _expiryTime = param1;
            }
        }

        private var _ownerName: String = "";

        public function get ownerName(): String {
            return _ownerName;
        }

        public function set ownerName(param1: String): void {
            _ownerName = param1;
        }

        public function get id(): int {
            return var_280;
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

        public function get sizeX(): int {
            return var_943;
        }

        public function set sizeX(param1: int): void {
            if (!var_25) {
                var_943 = param1;
            }
        }

        public function get sizeY(): int {
            return var_799;
        }

        public function set sizeY(param1: int): void {
            if (!var_25) {
                var_799 = param1;
            }
        }

        public function get sizeZ(): Number {
            return var_1397;
        }

        public function set sizeZ(param1: Number): void {
            if (!var_25) {
                var_1397 = param1;
            }
        }

        public function get type(): int {
            return var_329;
        }

        public function set type(param1: int): void {
            if (!var_25) {
                var_329 = param1;
            }
        }

        public function get state(): int {
            return var_149;
        }

        public function set state(param1: int): void {
            if (!var_25) {
                var_149 = param1;
            }
        }

        public function get data(): IStuffData {
            return var_47;
        }

        public function set data(param1: IStuffData): void {
            if (!var_25) {
                var_47 = param1;
            }
        }

        public function get staticClass(): String {
            return var_1496;
        }

        public function set staticClass(param1: String): void {
            if (!var_25) {
                var_1496 = param1;
            }
        }

        public function get extra(): int {
            return var_724;
        }

        public function set extra(param1: int): void {
            if (!var_25) {
                var_724 = param1;
            }
        }

        public function get usagePolicy(): int {
            return var_1198;
        }

        public function set usagePolicy(param1: int): void {
            var_1198 = param1;
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function set ownerId(param1: int): void {
            var_876 = param1;
        }

        public function get trustedSender(): Boolean {
            return var_1451;
        }

        public function set trustedSender(param1: Boolean): void {
            var_1451 = param1;
        }

        public function setReadOnly(): void {
            var_25 = true;
        }
    }
}
