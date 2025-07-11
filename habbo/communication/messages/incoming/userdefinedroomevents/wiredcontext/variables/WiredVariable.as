package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.utils.Map

    public class WiredVariable {

        public function WiredVariable(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            var _loc6_: int = 0;
            var _loc5_: String = null;
            super();
            var_1395 = param1.readLong();
            var_1355 = param1.readString();
            var_659 = param1.readInteger();
            var_1303 = param1.readInteger();
            var_1385 = param1.readBoolean();
            var_1179 = param1.readBoolean();
            var_885 = param1.readBoolean();
            var_815 = param1.readBoolean();
            var_1052 = param1.readBoolean();
            var_1184 = param1.readBoolean();
            var_1043 = param1.readBoolean();
            var_1206 = param1.readBoolean();
            var _loc2_: Boolean = param1.readBoolean();
            if (_loc2_) {
                var_584 = new Map();
                _loc3_ = param1.readInteger();
                _loc4_ = 0;
                while (_loc4_ < _loc3_) {
                    _loc6_ = param1.readInteger();
                    _loc5_ = param1.readString();
                    var_584.add(_loc6_, _loc5_);
                    _loc4_++;
                }
            }
        }
        private var var_1395: Number;
        private var var_1355: String;
        private var var_659: int;
        private var var_1303: int;
        private var var_1385: Boolean;
        private var var_1179: Boolean;
        private var var_885: Boolean;
        private var var_815: Boolean;
        private var var_1052: Boolean;
        private var var_1184: Boolean;
        private var var_1043: Boolean;
        private var var_1206: Boolean;
        private var var_584: Map;

        public function get variableId(): Number {
            return var_1395;
        }

        public function get variableName(): String {
            return var_1355;
        }

        public function get availabilityType(): int {
            return var_659;
        }

        public function get variableType(): int {
            return var_1303;
        }

        public function get alwaysAvailable(): Boolean {
            return var_1385;
        }

        public function get canCreateAndDelete(): Boolean {
            return var_1179;
        }

        public function get hasValue(): Boolean {
            return var_885;
        }

        public function get canWriteValue(): Boolean {
            return var_815;
        }

        public function get canInterceptChanges(): Boolean {
            return var_1052;
        }

        public function get isInvisible(): Boolean {
            return var_1184;
        }

        public function get canReadCreationTime(): Boolean {
            return var_1043;
        }

        public function get canReadLastUpdateTime(): Boolean {
            return var_1206;
        }

        public function get hasTextConnector(): Boolean {
            return var_584 != null;
        }

        public function get textConnector(): Map {
            return var_584;
        }

        public function get isStored(): Boolean {
            return var_659 < 100;
        }
    }
}
