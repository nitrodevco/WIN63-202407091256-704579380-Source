package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1381 implements IMessageParser {

        public function class_1381() {
            super();
        }
        private var var_801: Boolean;
        private var var_1205: Boolean;

        private var var_495: int;

        private var var_525: int;

        private var var_452: int;

        private var _furniTypeName: String;

        public function get furniTypeName(): String {
            return _furniTypeName;
        }

        public function get isWallItem(): Boolean {
            return var_801;
        }

        public function get buyout(): Boolean {
            return var_1205;
        }

        public function get priceInCredits(): int {
            return var_495;
        }

        public function get priceInActivityPoints(): int {
            return var_525;
        }

        public function get activityPointType(): int {
            return var_452;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_801 = param1.readBoolean();
            _furniTypeName = param1.readString();
            var_1205 = param1.readBoolean();
            var_495 = param1.readInteger();
            var_525 = param1.readInteger();
            var_452 = param1.readInteger();
            return true;
        }
    }
}
