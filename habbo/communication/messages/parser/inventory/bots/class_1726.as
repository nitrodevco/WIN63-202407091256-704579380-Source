package com.sulake.habbo.communication.messages.parser.inventory.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1726 {

        public function class_1726(param1: IMessageDataWrapper) {
            super();
            var_280 = param1.readInteger();
            _name = param1.readString();
            var_962 = param1.readString();
            var_129 = param1.readString();
            var_426 = param1.readString();
        }
        private var var_280: int;
        private var var_962: String;

        private var var_129: String;

        private var var_426: String;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get id(): int {
            return var_280;
        }

        public function get motto(): String {
            return var_962;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get gender(): String {
            return var_129;
        }
    }
}
