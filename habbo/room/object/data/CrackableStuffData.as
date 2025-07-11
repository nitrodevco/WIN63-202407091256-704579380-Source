package com.sulake.habbo.room.object.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.IRoomObjectModelController

    public class CrackableStuffData extends StuffDataBase implements IStuffData {

        public static const FORMAT_KEY: int = 7;

        private static const INTERNAL_STATE_KEY: String = "furniture_crackable_state";

        private static const INTERNAL_HIT_KEY: String = "furniture_crackable_hits";

        private static const INTERNAL_TARGET_KEY: String = "furniture_crackable_target";

        public function CrackableStuffData() {
            super();
        }
        private var var_149: String = "";
        private var var_294: int;

        private var _hits: int;

        public function get hits(): int {
            return _hits;
        }

        public function get target(): int {
            return var_294;
        }

        override public function initializeFromIncomingMessage(param1: IMessageDataWrapper): void {
            var_149 = param1.readString();
            _hits = param1.readInteger();
            var_294 = param1.readInteger();
            super.initializeFromIncomingMessage(param1);
        }

        override public function writeRoomObjectModel(param1: IRoomObjectModelController): void {
            super.writeRoomObjectModel(param1);
            param1.setNumber("furniture_data_format", 7);
            param1.setString("furniture_crackable_state", var_149);
            param1.setNumber("furniture_crackable_hits", _hits);
            param1.setNumber("furniture_crackable_target", var_294);
        }

        override public function initializeFromRoomObjectModel(param1: IRoomObjectModel): void {
            super.initializeFromRoomObjectModel(param1);
            var_149 = param1.getString("furniture_crackable_state");
            _hits = param1.getNumber("furniture_crackable_hits");
            var_294 = param1.getNumber("furniture_crackable_target");
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
