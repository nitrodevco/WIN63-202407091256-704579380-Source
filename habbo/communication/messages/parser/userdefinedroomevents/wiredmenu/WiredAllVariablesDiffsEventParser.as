package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable

    import flash.utils.Dictionary

    public class WiredAllVariablesDiffsEventParser implements IMessageParser {

        public function WiredAllVariablesDiffsEventParser() {
            super();
        }
        private var var_610: Boolean;

        private var var_307: Vector.<Number>;

        private var var_346: Dictionary;

        private var _allVariablesHash: int;

        public function get allVariablesHash(): int {
            return _allVariablesHash;
        }

        public function get isLastChunk(): Boolean {
            return var_610;
        }

        public function get removedVariables(): Vector.<Number> {
            return var_307;
        }

        public function get addedOrUpdated(): Dictionary {
            return var_346;
        }

        public function flush(): Boolean {
            _allVariablesHash = 0;
            var_610 = false;
            var_307 = null;
            var_346 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc5_: int = 0;
            var _loc6_: int = 0;
            var _loc4_: WiredVariable = null;
            _allVariablesHash = param1.readInteger();
            var_610 = param1.readBoolean();
            var _loc2_: int = param1.readInteger();
            var_307 = new Vector.<Number>();
            _loc5_ = 0;
            while (_loc5_ < _loc2_) {
                var_307.push(param1.readLong());
                _loc5_++;
            }
            var _loc3_: int = param1.readInteger();
            var_346 = new Dictionary();
            _loc5_ = 0;
            while (_loc5_ < _loc3_) {
                _loc6_ = param1.readInteger();
                _loc4_ = new WiredVariable(param1);
                var_346[_loc4_] = _loc6_;
                _loc5_++;
            }
            return true;
        }
    }
}
