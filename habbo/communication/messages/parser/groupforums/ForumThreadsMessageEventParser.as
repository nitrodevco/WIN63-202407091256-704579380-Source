package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ForumThreadsMessageEventParser implements IMessageParser {

        public function ForumThreadsMessageEventParser() {
            super();
        }
        private var var_373: int;
        private var var_658: Array;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _amount: int;

        public function get amount(): int {
            return _amount;
        }

        public function get startIndex(): int {
            return var_373;
        }

        public function get threads(): Array {
            return var_658;
        }

        public function flush(): Boolean {
            _groupId = -1;
            var_373 = -1;
            _amount = -1;
            var_658 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            _groupId = param1.readInteger();
            var_373 = param1.readInteger();
            _amount = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < amount) {
                var_658.push(class_1740.readFromMessage(param1));
                _loc2_++;
            }
            return true;
        }
    }
}
