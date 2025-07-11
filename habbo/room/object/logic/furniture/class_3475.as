package com.sulake.habbo.room.object.logic.furniture {
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage
    import com.sulake.habbo.room.object.data.LegacyStuffData
    import com.sulake.room.messages.RoomObjectUpdateMessage

    public class class_3475 extends FurnitureMultiStateLogic {

        public function class_3475() {
            super();
        }
        private var var_4156: int = 0;
        private var var_4655: Number = 0;
        private var var_2900: int = 0;

        override public function processUpdateMessage(param1: RoomObjectUpdateMessage): void {
            if (param1 == null) {
                return;
            }
            var _loc2_: RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
            if (_loc2_ != null) {
                handleDataUpdateMessage(_loc2_);
                return;
            }
            super.processUpdateMessage(param1);
        }

        override public function update(param1: int): void {
            var _loc2_: LegacyStuffData = null;
            var _loc3_: RoomObjectDataUpdateMessage = null;
            if (var_2900 > 0 && param1 >= var_2900) {
                var_2900 = 0;
                _loc2_ = new LegacyStuffData();
                _loc2_.setString(String(var_4156));
                _loc3_ = new RoomObjectDataUpdateMessage(var_4156, _loc2_, var_4655);
                super.processUpdateMessage(_loc3_);
            }
            super.update(param1);
        }

        private function handleDataUpdateMessage(param1: RoomObjectDataUpdateMessage): void {
            var _loc3_: LegacyStuffData = null;
            var _loc4_: int = param1.state / 1000;
            var _loc2_: int = param1.state % 1000;
            if (_loc2_ == 0) {
                var_2900 = 0;
                _loc3_ = new LegacyStuffData();
                _loc3_.setString(String(_loc4_));
                param1 = new RoomObjectDataUpdateMessage(_loc4_, _loc3_, param1.extra);
                super.processUpdateMessage(param1);
            } else {
                var_4156 = _loc4_;
                var_4655 = param1.extra;
                var_2900 = lastUpdateTime + _loc2_;
            }
        }
    }
}
