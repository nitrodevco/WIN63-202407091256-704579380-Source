package com.sulake.habbo.room.object.logic.furniture {
    import com.sulake.habbo.room.events.RoomObjectDataRequestEvent
    import com.sulake.room.object.IRoomObjectModel

    public class class_3506 extends FurnitureLogic {

        public function class_3506() {
            super();
        }

        override public function get widget(): String {
            return "RWE_RENTABLESPACE";
        }

        override public function getEventTypes(): Array {
            return getAllEventTypes(super.getEventTypes(), ["RODRE_CURRENT_USER_ID"]);
        }

        override public function update(param1: int): void {
            super.update(param1);
            if (!object.getModel().hasNumber("session_current_user_id")) {
                eventDispatcher.dispatchEvent(new RoomObjectDataRequestEvent("RODRE_CURRENT_USER_ID", object));
            }
            var _loc4_: IRoomObjectModel;
            var _loc2_: String = String((_loc4_ = object.getModel()).getStringToStringMap("furniture_data").getValue("renterId"));
            var _loc3_: Number = Number(_loc4_.getNumber("session_current_user_id"));
            if (_loc2_ != null) {
                if (Number(_loc2_) == _loc3_) {
                    object.setState(2, 0);
                } else {
                    object.setState(1, 0);
                }
            } else {
                object.setState(0, 0);
            }
        }
    }
}
