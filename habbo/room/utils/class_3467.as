package com.sulake.habbo.room.utils {
    import com.sulake.room.object.IRoomObjectController

    [SecureSWF(rename="true")]
    public class class_3467 {

        public function class_3467(param1: IRoomObjectController, param2: Boolean) {
            super();
            var_2060 = param1;
            var_4385 = param2;
        }
        private var var_2060: IRoomObjectController;
        private var var_4385: Boolean;

        public function get object(): IRoomObjectController {
            return var_2060;
        }

        public function get groupBadge(): Boolean {
            return var_4385;
        }
    }
}
