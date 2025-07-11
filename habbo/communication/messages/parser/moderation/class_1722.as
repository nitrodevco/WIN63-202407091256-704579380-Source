package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.runtime.IDisposable

    import flash.utils.getTimer

    [SecureSWF(rename="true")]
    public class class_1722 implements IDisposable {

        public static const STATE_OPEN: int = 1;

        public static const const_391: int = 2;

        public static const const_180: int = 3;

        public function class_1722(param1: int, param2: int, param3: int, param4: int, param5: Number, param6: int, param7: int, param8: int, param9: String, param10: int, param11: String, param12: int, param13: String, param14: String, param15: int, param16: Array) {
            super();
            var_546 = param1;
            var_149 = param2;
            var_634 = param3;
            var_1133 = param4;
            var_722 = param5;
            _priority = param6;
            var_1131 = param7;
            var_1440 = param8;
            var_1414 = param9;
            var_874 = param10;
            _reportedUserName = param11;
            var_1062 = param12;
            var_789 = param13;
            var_368 = param14;
            var_1211 = param15;
            var_312 = param16;
            var_890 = getTimer();
        }
        private var var_546: int;
        private var var_149: int;
        private var var_634: int;
        private var var_1133: int;
        private var var_722: Number;
        private var var_1131: int;

        private var var_1440: int;

        private var var_1414: String;

        private var var_874: int;
        private var var_1062: int;
        private var var_789: String;
        private var var_368: String;
        private var var_1211: int;
        private var var_312: Array;
        private var var_318: Boolean = false;
        private var var_890: Number;

        private var _priority: int;

        public function get priority(): int {
            return _priority;
        }

        private var _reportedUserName: String;

        public function get reportedUserName(): String {
            return _reportedUserName;
        }

        public function get issueId(): int {
            return var_546;
        }

        public function get state(): int {
            return var_149;
        }

        public function get categoryId(): int {
            return var_634;
        }

        public function get reportedCategoryId(): int {
            return var_1133;
        }

        public function get issueAgeInMilliseconds(): Number {
            return var_722;
        }

        public function get groupingId(): int {
            return var_1131;
        }

        public function get reporterUserId(): int {
            return var_1440;
        }

        public function get reporterUserName(): String {
            return var_1414;
        }

        public function get reportedUserId(): int {
            return var_874;
        }

        public function get pickerUserId(): int {
            return var_1062;
        }

        public function get pickerUserName(): String {
            return var_789;
        }

        public function get message(): String {
            return var_368;
        }

        public function get chatRecordId(): int {
            return var_1211;
        }

        public function get patterns(): Array {
            return var_312;
        }

        public function get disposed(): Boolean {
            return var_318;
        }

        public function dispose(): void {
            if (disposed) {
                return;
            }
            for each(var _loc1_ in var_312) {
                _loc1_.dispose();
            }
            var_312 = [];
            var_318 = true;
        }

        public function getOpenTime(param1: int): String {
            var _loc5_: int;
            var _loc7_: int;
            var _loc6_: int = (_loc5_ = (_loc7_ = (var_722 + param1 - var_890) / 1000) / 60) % 60;
            var _loc4_: int = _loc5_ / 60;
            var _loc2_: String = (_loc6_ < 10 ? "0" : "") + _loc6_;
            var _loc3_: String = (_loc4_ < 10 ? "0" : "") + _loc4_;
            return _loc3_ + ":" + _loc2_;
        }
    }
}
