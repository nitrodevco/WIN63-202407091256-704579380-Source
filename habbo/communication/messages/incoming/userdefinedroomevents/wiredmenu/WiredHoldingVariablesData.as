package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.utils.Map

    public class WiredHoldingVariablesData {

        private static var var_1602: int = 0;

        private static var var_1588: int = 1;

        private static var var_1628: int = 0;

        public function WiredHoldingVariablesData(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc4_: Number = NaN;
            var _loc5_: int = 0;
            super();
            var_329 = param1.readInteger();
            if (var_329 == var_1602) {
                var_455 = param1.readInteger();
            } else if (var_329 == var_1588) {
                var_771 = param1.readInteger();
            }
            var_677 = new Map();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = param1.readLong();
                _loc5_ = param1.readInteger();
                var_677.add(_loc4_, _loc5_);
                _loc3_ += 1;
            }
        }
        private var var_329: int;
        private var var_771: int;
        private var var_455: int;
        private var var_677: Map;

        public function get type(): int {
            return var_329;
        }

        public function get userIndex(): int {
            return var_771;
        }

        public function get objectId(): int {
            return var_455;
        }

        public function get variableValues(): Map {
            return var_677;
        }
    }
}
