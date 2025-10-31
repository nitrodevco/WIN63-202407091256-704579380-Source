package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ForumsListMessageEventParser implements IMessageParser {

        public function ForumsListMessageEventParser() {
            super();
        }
        private var var_1282: int;
        private var var_373: int;

        private var _totalAmount: int;

        public function get totalAmount(): int {
            return _totalAmount;
        }

        private var _amount: int;

        public function get amount(): int {
            return _amount;
        }

        private var _forums: Array;

        public function get forums(): Array {
            return _forums;
        }

        public function get listCode(): int {
            return var_1282;
        }

        public function get startIndex(): int {
            return var_373;
        }

        public function flush(): Boolean {
            _forums = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_1282 = param1.readInteger();
            _totalAmount = param1.readInteger();
            var_373 = param1.readInteger();
            _amount = param1.readInteger();
            _forums = [];
            _loc2_ = 0;
            while (_loc2_ < amount) {
                _forums.push(class_1754.readFromMessage(param1));
                _loc2_++;
            }
            return true;
        }
    }
}
