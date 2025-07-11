package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.habbo.room.IStuffData
    import com.sulake.habbo.room.object.data.LegacyStuffData

    [SecureSWF(rename="true")]
    public class class_1721 {

        public function class_1721(param1: int, param2: int, param3: IStuffData) {
            var_47 = new LegacyStuffData();
            super();
            var_280 = param1;
            var_149 = param2;
            var_47 = param3;
        }
        private var var_280: int = 0;
        private var var_149: int = 0;
        private var var_47: IStuffData;

        public function get id(): int {
            return var_280;
        }

        public function get state(): int {
            return var_149;
        }

        public function get data(): IStuffData {
            return var_47;
        }
    }
}
