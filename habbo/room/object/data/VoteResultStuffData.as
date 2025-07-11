package com.sulake.habbo.room.object.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.utils.Map
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.IRoomObjectModelController

    public class VoteResultStuffData extends StuffDataBase implements IStuffData {

        public static const FORMAT_KEY: int = 3;

        private static const INTERNAL_STATE_KEY: String = "s";

        private static const INTERNAL_RESULT_KEY: String = "r";

        public function VoteResultStuffData() {
            super();
        }
        private var var_149: String = "";
        private var var_152: int;

        public function get result(): int {
            return var_152;
        }

        override public function initializeFromIncomingMessage(param1: IMessageDataWrapper): void {
            var_149 = param1.readString();
            var_152 = param1.readInteger();
            super.initializeFromIncomingMessage(param1);
        }

        override public function writeRoomObjectModel(param1: IRoomObjectModelController): void {
            super.writeRoomObjectModel(param1);
            param1.setNumber("furniture_data_format", 3);
            var _loc2_: Map = new Map();
            _loc2_.add("s", var_149);
            _loc2_.add("r", var_152.toString());
            param1.setStringToStringMap("furniture_data", _loc2_);
        }

        override public function initializeFromRoomObjectModel(param1: IRoomObjectModel): void {
            super.initializeFromRoomObjectModel(param1);
            var _loc2_: Map = param1.getStringToStringMap("furniture_data");
            var_149 = _loc2_.getValue("s");
            var_152 = _loc2_.getValue("r");
        }

        override public function getLegacyString(): String {
            return var_149;
        }

        override public function compare(param1: IStuffData): Boolean {
            return true;
        }

        public function setString(param1: String): void {
            var_149 = param1;
        }
    }
}
