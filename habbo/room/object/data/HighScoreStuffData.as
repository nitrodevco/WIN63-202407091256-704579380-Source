package com.sulake.habbo.room.object.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.room.IStuffData
    import com.sulake.room.object.IRoomObjectModel
    import com.sulake.room.object.IRoomObjectModelController

    public class HighScoreStuffData extends StuffDataBase implements IStuffData {

        public static const FORMAT_KEY: int = 6;

        public function HighScoreStuffData() {
            super();
        }
        private var var_149: String = "";
        private var var_349: int = -1;
        private var var_351: int = -1;
        private var var_97: Vector.<HighScoreData>;

        public function get scoreType(): int {
            return var_349;
        }

        public function get clearType(): int {
            return var_351;
        }

        public function get entries(): Vector.<HighScoreData> {
            return var_97;
        }

        override public function initializeFromIncomingMessage(param1: IMessageDataWrapper): void {
            var _loc5_: int = 0;
            var _loc2_: HighScoreData = null;
            var _loc4_: int = 0;
            var _loc6_: int = 0;
            var_97 = new Vector.<HighScoreData>();
            var_149 = param1.readString();
            var_349 = param1.readInteger();
            var_351 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc5_ = 0;
            while (_loc5_ < _loc3_) {
                _loc2_ = new HighScoreData();
                _loc2_.score = param1.readInteger();
                _loc4_ = param1.readInteger();
                _loc6_ = 0;
                while (_loc6_ < _loc4_) {
                    _loc2_.addUser(param1.readString());
                    _loc6_++;
                }
                var_97.push(_loc2_);
                _loc5_++;
            }
        }

        override public function initializeFromRoomObjectModel(param1: IRoomObjectModel): void {
            var _loc4_: int = 0;
            var _loc2_: HighScoreData = null;
            var_97 = new Vector.<HighScoreData>();
            super.initializeFromRoomObjectModel(param1);
            var_349 = param1.getNumber("furniture_highscore_score_type");
            var_351 = param1.getNumber("furniture_highscore_clear_type");
            var _loc3_: int = param1.getNumber("furniture_highscore_data_entry_count");
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = new HighScoreData();
                _loc2_.score = param1.getNumber("furniture_highscore_data_entry_base_score_" + _loc4_);
                _loc2_.users = param1.getStringArray("furniture_highscore_data_entry_base_users_" + _loc4_);
                var_97.push(_loc2_);
                _loc4_++;
            }
        }

        override public function writeRoomObjectModel(param1: IRoomObjectModelController): void {
            var _loc3_: int = 0;
            var _loc2_: HighScoreData = null;
            super.writeRoomObjectModel(param1);
            param1.setNumber("furniture_data_format", 6);
            param1.setNumber("furniture_highscore_score_type", var_349);
            param1.setNumber("furniture_highscore_clear_type", var_351);
            if (var_97) {
                param1.setNumber("furniture_highscore_data_entry_count", var_97.length);
                _loc3_ = 0;
                while (_loc3_ < var_97.length) {
                    _loc2_ = var_97[_loc3_];
                    param1.setNumber("furniture_highscore_data_entry_base_score_" + _loc3_, _loc2_.score);
                    param1.setStringArray("furniture_highscore_data_entry_base_users_" + _loc3_, _loc2_.users);
                    _loc3_++;
                }
            }
        }

        override public function getLegacyString(): String {
            return var_149;
        }
    }
}
