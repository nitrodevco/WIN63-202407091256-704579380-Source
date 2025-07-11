package com.sulake.habbo.room.utils {
    import com.sulake.habbo.room.ISelectedRoomObjectData
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_3413 implements ISelectedRoomObjectData {

        public function class_3413(param1: int, param2: int, param3: String, param4: IVector3d, param5: IVector3d, param6: int = 0, param7: String = null, param8: IStuffData = null, param9: int = -1, param10: int = -1, param11: String = null) {
            super();
            var_280 = param1;
            var_638 = param2;
            var_4551 = param3;
            var_501 = new Vector3d();
            var_501.assign(param4);
            var_643 = new Vector3d();
            var_643.assign(param5);
            var_1311 = param6;
            var_4685 = param7;
            var_1091 = param8;
            var_149 = param9;
            _animFrame = param10;
            var_917 = param11;
        }
        private var var_280: int = 0;
        private var var_638: int = 0;
        private var var_4551: String = "";
        private var var_501: Vector3d = null;
        private var var_643: Vector3d = null;
        private var var_1311: int = 0;
        private var var_4685: String = null;
        private var var_1091: IStuffData = null;
        private var var_149: int = -1;
        private var var_917: String = null;

        private var _animFrame: int = -1;

        public function get animFrame(): int {
            return _animFrame;
        }

        public function get id(): int {
            return var_280;
        }

        public function get category(): int {
            return var_638;
        }

        public function get operation(): String {
            return var_4551;
        }

        public function get loc(): Vector3d {
            return var_501;
        }

        public function get dir(): Vector3d {
            return var_643;
        }

        public function get typeId(): int {
            return var_1311;
        }

        public function get instanceData(): String {
            return var_4685;
        }

        public function get stuffData(): IStuffData {
            return var_1091;
        }

        public function get state(): int {
            return var_149;
        }

        public function get posture(): String {
            return var_917;
        }

        public function dispose(): void {
            var_501 = null;
            var_643 = null;
        }
    }
}
