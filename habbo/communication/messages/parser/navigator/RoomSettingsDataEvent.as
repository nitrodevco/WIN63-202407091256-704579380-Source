package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.runtime.IDisposable
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1675
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1731
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1732

    [SecureSWF(rename="true")]
    public class RoomSettingsDataEvent implements IMessageParser, IDisposable {

        public function RoomSettingsDataEvent() {
            super();
        }
        private var var_1525: Boolean;
        private var var_1556: Boolean;
        private var var_1533: Boolean;
        private var var_47: class_1675;
        private var var_1530: Boolean;
        private var var_454: class_1731;
        private var var_526: class_1732;

        public function get disposed(): Boolean {
            return var_454 == null;
        }

        public function get enterRoom(): Boolean {
            return var_1525;
        }

        public function get data(): class_1675 {
            return var_47;
        }

        public function get roomForward(): Boolean {
            return var_1556;
        }

        public function get staffPick(): Boolean {
            return var_1533;
        }

        public function get isGroupMember(): Boolean {
            return var_1530;
        }

        public function get roomModerationSettings(): class_1731 {
            return var_454;
        }

        public function get chatSettings(): class_1732 {
            return var_526;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_1525 = param1.readBoolean();
            this.var_47 = new class_1675(param1);
            this.var_1556 = param1.readBoolean();
            this.var_1533 = param1.readBoolean();
            this.var_1530 = param1.readBoolean();
            var _loc2_: Boolean = param1.readBoolean();
            this.var_454 = new class_1731(param1);
            this.var_47.allInRoomMuted = _loc2_;
            this.var_47.canMute = param1.readBoolean();
            this.var_526 = new class_1732(param1);
            return true;
        }

        public function dispose(): void {
            var_454 = null;
        }
    }
}
