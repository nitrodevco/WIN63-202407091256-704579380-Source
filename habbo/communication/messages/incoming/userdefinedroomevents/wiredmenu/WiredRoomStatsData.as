package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class WiredRoomStatsData {

        public function WiredRoomStatsData(param1: IMessageDataWrapper) {
            super();
            var_1224 = param1.readDouble();
            var_791 = param1.readDouble();
            var_1475 = param1.readBoolean();
            var_1185 = param1.readInteger();
            var_995 = param1.readInteger();
            var_1245 = param1.readInteger();
            var_940 = param1.readInteger();
        }
        private var var_1224: Number;
        private var var_791: Number;
        private var var_1475: Boolean;
        private var var_1185: int;
        private var var_995: int;
        private var var_1245: int;
        private var var_940: int;

        public function get executionCost(): Number {
            return var_1224;
        }

        public function get executionCostCap(): Number {
            return var_791;
        }

        public function get isHeavy(): Boolean {
            return var_1475;
        }

        public function get floorItemCount(): int {
            return var_1185;
        }

        public function get floorItemCap(): int {
            return var_995;
        }

        public function get wallItemCount(): int {
            return var_1245;
        }

        public function get wallItemCap(): int {
            return var_940;
        }
    }
}
