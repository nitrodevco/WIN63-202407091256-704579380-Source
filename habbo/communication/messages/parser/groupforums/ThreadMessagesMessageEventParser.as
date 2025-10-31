package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ThreadMessagesMessageEventParser implements IMessageParser {

        public function ThreadMessagesMessageEventParser() {
            super();
        }
        private var var_345: int;

        private var var_373: int;
        private var var_693: Array;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _amount: int;

        public function get amount(): int {
            return _amount;
        }

        public function get threadId(): int {
            return var_345;
        }

        public function get startIndex(): int {
            return var_373;
        }

        public function get messages(): Array {
            return var_693;
        }

        public function flush(): Boolean {
            _groupId = -1;
            var_345 = -1;
            var_373 = -1;
            _amount = -1;
            var_693 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var _loc3_: class_1666 = null;
            _groupId = param1.readInteger();
            var_345 = param1.readInteger();
            var_373 = param1.readInteger();
            _amount = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _amount) {
                _loc3_ = class_1666.readFromMessage(param1);
                _loc3_.groupID = _groupId;
                _loc3_.threadId = var_345;
                var_693.push(_loc3_);
                _loc2_++;
            }
            return true;
        }
    }
}
