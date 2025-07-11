package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class InputSourcesConf {

        private static function readAllowedSources(param1: IMessageDataWrapper): Array {
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            var _loc6_: int = 0;
            var _loc3_: Array = [];
            var _loc2_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_[_loc4_] = [];
                _loc5_ = param1.readInteger();
                _loc6_ = 0;
                while (_loc6_ < _loc5_) {
                    _loc3_[_loc4_][_loc6_] = param1.readInteger();
                    _loc6_++;
                }
                _loc4_++;
            }
            return _loc3_;
        }

        private static function readDefaultSources(param1: IMessageDataWrapper): Array {
            var _loc4_: int = 0;
            var _loc2_: Array = [];
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_.push(param1.readInteger());
                _loc4_++;
            }
            return _loc2_;
        }

        public function InputSourcesConf(param1: IMessageDataWrapper) {
            super();
            var_732 = readAllowedSources(param1);
            var_720 = readAllowedSources(param1);
            var_204 = readDefaultSources(param1);
            var_623 = readDefaultSources(param1);
        }
        private var var_732: Array;
        private var var_720: Array;
        private var var_204: Array;
        private var var_623: Array;

        public function get amountFurniSelections(): int {
            return var_732.length;
        }

        public function get amountUserSelections(): int {
            return var_720.length;
        }

        public function get defaultFurniSources(): Array {
            return var_204;
        }

        public function get defaultUserSources(): Array {
            return var_623;
        }

        public function getAllowedFurniSources(param1: int): Array {
            return var_732[param1];
        }

        public function getAllowedUserSources(param1: int): Array {
            return var_720[param1];
        }

        public function allowFurniSelection(): Boolean {
            var _loc1_: int = 0;
            _loc1_ = 0;
            while (_loc1_ < amountFurniSelections) {
                if (getAllowedFurniSources(_loc1_).indexOf(100) != -1 || getAllowedFurniSources(_loc1_).indexOf(101) != -1) {
                    return true;
                }
                _loc1_++;
            }
            return false;
        }

        public function isFurniSelectionDefault(): Boolean {
            return var_204.indexOf(100) != -1 || var_204.indexOf(101) != -1;
        }

        internal function isUsingAdvancedSettings(param1: Array, param2: Array): Boolean {
            var _loc5_: int = 0;
            var _loc4_: int = 0;
            var _loc3_: int = 0;
            _loc5_ = 0;
            while (_loc5_ < var_204.length) {
                if ((_loc4_ = int(var_204[_loc5_])) != param1[_loc5_]) {
                    return true;
                }
                _loc5_++;
            }
            _loc5_ = 0;
            while (_loc5_ < var_623.length) {
                _loc3_ = int(var_623[_loc5_]);
                if (_loc3_ != param2[_loc5_]) {
                    return true;
                }
                _loc5_++;
            }
            return false;
        }
    }
}
