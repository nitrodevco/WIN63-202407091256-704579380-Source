package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1658
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1731
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1732

    [SecureSWF(rename="true")]
    public class RoomSettingsDataEventParser implements IMessageParser {

        public function RoomSettingsDataEventParser() {
            super();
        }
        private var var_27: class_1658;

        public function get data(): class_1658 {
            return var_27;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_27 = new class_1658();
            var_27.roomId = param1.readInteger();
            var_27.name = param1.readString();
            var_27.description = param1.readString();
            var_27.doorMode = param1.readInteger();
            var_27.categoryId = param1.readInteger();
            var_27.maximumVisitors = param1.readInteger();
            var_27.maximumVisitorsLimit = param1.readInteger();
            var_27.tags = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_27.tags.push(param1.readString());
                _loc3_++;
            }
            var_27.tradeMode = param1.readInteger();
            var_27.allowPets = param1.readInteger() == 1;
            var_27.allowFoodConsume = param1.readInteger() == 1;
            var_27.allowWalkThrough = param1.readInteger() == 1;
            var_27.hideWalls = param1.readInteger() == 1;
            var_27.wallThickness = param1.readInteger();
            var_27.floorThickness = param1.readInteger();
            var_27.chatSettings = new class_1732(param1);
            var_27.allowNavigatorDynamicCats = param1.readBoolean();
            var_27.roomModerationSettings = new class_1731(param1);
            var_27.hiddenByBc = param1.readBoolean();
            return true;
        }

        public function flush(): Boolean {
            var_27 = null;
            return true;
        }
    }
}
