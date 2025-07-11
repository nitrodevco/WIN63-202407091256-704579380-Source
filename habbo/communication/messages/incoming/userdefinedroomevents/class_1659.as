package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.WiredContext

    [SecureSWF(rename="true")]
    public class class_1659 {

        public function class_1659(param1: IMessageDataWrapper) {
            var _loc6_: int = 0;
            var _loc2_: int = 0;
            var_715 = [];
            var_436 = [];
            var_689 = [];
            var_676 = [];
            var_656 = [];
            super();
            var_992 = param1.readInteger();
            var _loc7_: int = param1.readInteger();
            _loc6_ = 0;
            while (_loc6_ < _loc7_) {
                _loc2_ = param1.readInteger();
                var_715.push(_loc2_);
                _loc6_++;
            }
            var_769 = param1.readInteger();
            var_280 = param1.readInteger();
            var_1457 = param1.readString();
            var _loc3_: int = param1.readInteger();
            _loc6_ = 0;
            while (_loc6_ < _loc3_) {
                var_436.push(param1.readInteger());
                _loc6_++;
            }
            var _loc5_: int = param1.readInteger();
            _loc6_ = 0;
            while (_loc6_ < _loc5_) {
                var_689.push(param1.readLong());
                _loc6_++;
            }
            var _loc4_: int = param1.readInteger();
            _loc6_ = 0;
            while (_loc6_ < _loc4_) {
                var_676.push(param1.readInteger());
                _loc6_++;
            }
            var _loc8_: int = param1.readInteger();
            _loc6_ = 0;
            while (_loc6_ < _loc8_) {
                var_656.push(param1.readInteger());
                _loc6_++;
            }
            var_1078 = param1.readInteger();
            readDefinitionSpecifics(param1);
            var_820 = param1.readBoolean();
            var_746 = new InputSourcesConf(param1);
            var_980 = param1.readBoolean();
            readTypeSpecifics(param1);
            var_1189 = param1.bytesAvailable > 0 ? new WiredContext(param1) : WiredContext.EMPTY;
        }
        private var var_992: int;
        private var var_715: Array;
        private var var_280: int;
        private var var_1457: String;
        private var var_436: Array;
        private var var_689: Array;
        private var var_769: int;
        private var var_1078: int;
        private var var_676: Array;
        private var var_656: Array;
        private var var_820: Boolean;
        private var var_746: InputSourcesConf;
        private var var_980: Boolean;
        private var var_1189: WiredContext;

        public function get furniLimit(): int {
            return var_992;
        }

        public function get stuffIds(): Array {
            return var_715;
        }

        public function get id(): int {
            return var_280;
        }

        public function get stringParam(): String {
            return var_1457;
        }

        public function get intParams(): Array {
            return var_436;
        }

        public function get variableIds(): Array {
            return var_689;
        }

        public function get furniSourceTypes(): Array {
            return var_676;
        }

        public function get userSourceTypes(): Array {
            return var_656;
        }

        public function get advancedMode(): Boolean {
            return var_820;
        }

        public function get inputSourcesConf(): InputSourcesConf {
            return var_746;
        }

        public function get code(): int {
            return var_1078;
        }

        public function get stuffTypeId(): int {
            return var_769;
        }

        public function get allowWallFurni(): Boolean {
            return var_980;
        }

        public function get wiredContext(): WiredContext {
            return var_1189;
        }

        public function get usingCustomInputSources(): Boolean {
            return var_746.isUsingAdvancedSettings(furniSourceTypes, userSourceTypes);
        }

        public function getBoolean(param1: int): Boolean {
            return var_436[param1] == 1;
        }

        protected function readDefinitionSpecifics(param1: IMessageDataWrapper): void {
        }

        protected function readTypeSpecifics(param1: IMessageDataWrapper): void {
        }
    }
}
