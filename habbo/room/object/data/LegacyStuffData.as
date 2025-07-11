package com.sulake.habbo.room.object.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.IRoomObjectModelController

    public class LegacyStuffData extends StuffDataBase implements IStuffData {

        public static const FORMAT_KEY: int = 0;

        public function LegacyStuffData() {
            super();
        }
        private var var_47: String = "";

        override public function initializeFromIncomingMessage(param1: IMessageDataWrapper): void {
            var_47 = param1.readString();
            super.initializeFromIncomingMessage(param1);
        }

        override public function initializeFromRoomObjectModel(param1: IRoomObjectModel): void {
            super.initializeFromRoomObjectModel(param1);
            var_47 = param1.getString("furniture_data");
        }

        override public function writeRoomObjectModel(param1: IRoomObjectModelController): void {
            super.writeRoomObjectModel(param1);
            param1.setNumber("furniture_data_format", 0);
            param1.setString("furniture_data", var_47);
        }

        override public function getLegacyString(): String {
            return var_47;
        }

        override public function compare(param1: IStuffData): Boolean {
            return var_47 == param1.getLegacyString();
        }

        public function setString(param1: String): void {
            var_47 = param1;
        }
    }
}
