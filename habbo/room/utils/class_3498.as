package com.sulake.habbo.room.utils {
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_3498 {

        public function class_3498(param1: int, param2: int, param3: String, param4: IVector3d, param5: IVector3d, param6: int, param7: IStuffData, param8: Number = NaN, param9: int = -1, param10: int = 0, param11: int = 0, param12: String = "", param13: Boolean = true, param14: Boolean = true, param15: Number = -1) {
            var_501 = new Vector3d();
            var_643 = new Vector3d();
            super();
            var_280 = param1;
            var_1311 = param2;
            var_329 = param3;
            var_501.assign(param4);
            var_643.assign(param5);
            var_149 = param6;
            var_47 = param7;
            var_724 = param8;
            _expiryTime = param9;
            var_1198 = param10;
            var_876 = param11;
            _ownerName = param12;
            var_4657 = param13;
            _realRoomObject = param14;
            var_1397 = param15;
        }
        private var var_280: int = 0;
        private var var_1311: int = 0;
        private var var_329: String = null;
        private var var_501: Vector3d;
        private var var_643: Vector3d;
        private var var_149: int = 0;
        private var var_47: IStuffData = null;
        private var var_724: Number = NaN;
        private var var_1198: int = 0;

        private var var_876: int = 0;
        private var var_4657: Boolean = true;
        private var var_1397: Number;

        private var _expiryTime: int = -1;

        public function get expiryTime(): int {
            return _expiryTime;
        }

        private var _ownerName: String = "";

        public function get ownerName(): String {
            return _ownerName;
        }

        private var _realRoomObject: Boolean = true;

        public function get realRoomObject(): Boolean {
            return _realRoomObject;
        }

        public function get id(): int {
            return var_280;
        }

        public function get typeId(): int {
            return var_1311;
        }

        public function get type(): String {
            return var_329;
        }

        public function get loc(): IVector3d {
            return var_501;
        }

        public function get dir(): IVector3d {
            return var_643;
        }

        public function get state(): int {
            return var_149;
        }

        public function get data(): IStuffData {
            return var_47;
        }

        public function get extra(): Number {
            return var_724;
        }

        public function get usagePolicy(): int {
            return var_1198;
        }

        public function get ownerId(): int {
            return var_876;
        }

        public function get synchronized(): Boolean {
            return var_4657;
        }

        public function get sizeZ(): Number {
            return var_1397;
        }
    }
}
