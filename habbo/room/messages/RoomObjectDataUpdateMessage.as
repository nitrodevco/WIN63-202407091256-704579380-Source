package com.sulake.habbo.room.messages {
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectDataUpdateMessage(param1: int, param2: IStuffData, param3: Number = NaN) {
            super(null, null);
            var_149 = param1;
            var_47 = param2;
            var_724 = param3;
        }
        private var var_149: int;
        private var var_47: IStuffData = null;
        private var var_724: Number = NaN;

        public function get state(): int {
            return var_149;
        }

        public function get data(): IStuffData {
            return var_47;
        }

        public function get extra(): Number {
            return var_724;
        }
    }
}
