package com.sulake.habbo.communication.messages.parser.game.score {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1637 {

        public function class_1637(param1: IMessageDataWrapper) {
            super();
            _name = param1.readString();
            var_426 = param1.readString();
            var_129 = param1.readString();
            var_931 = param1.readInteger();
            var_367 = param1.readInteger();
        }
        private var var_426: String;

        private var var_129: String;

        private var var_931: int;

        private var var_367: int;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get gender(): String {
            return var_129;
        }

        public function get rank(): int {
            return var_931;
        }

        public function get score(): int {
            return var_367;
        }
    }
}
