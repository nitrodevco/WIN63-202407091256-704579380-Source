package com.sulake.habbo.room.object {
    import com.sulake.room.utils.IVector3d
    import com.sulake.room.utils.Vector3d

    public class RoomPlaneBitmapMaskData {

        public static const MASK_CATEGORY_WINDOW: String = "window";

        public static const MASK_CATEGORY_HOLE: String = "hole";

        public function RoomPlaneBitmapMaskData(param1: String, param2: IVector3d, param3: String) {
            super();
            this.type = param1;
            this.loc = param2;
            this.category = param3;
        }
        private var var_501: Vector3d = null;
        private var var_329: String = null;
        private var var_638: String = null;

        public function get loc(): IVector3d {
            return var_501;
        }

        public function set loc(param1: IVector3d): void {
            if (var_501 == null) {
                var_501 = new Vector3d();
            }
            var_501.assign(param1);
        }

        public function get type(): String {
            return var_329;
        }

        public function set type(param1: String): void {
            var_329 = param1;
        }

        public function get category(): String {
            return var_638;
        }

        public function set category(param1: String): void {
            var_638 = param1;
        }

        public function dispose(): void {
            var_501 = null;
        }
    }
}
