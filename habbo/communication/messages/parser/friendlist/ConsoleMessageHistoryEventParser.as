package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_1741

    [SecureSWF(rename="true")]
    public class ConsoleMessageHistoryEventParser implements IMessageParser {

        public function ConsoleMessageHistoryEventParser() {
            super();
        }
        private var _chatId: int;
        private var _historyFragment: Array;

        public function get chatId(): int {
            return _chatId;
        }

        public function get historyFragment(): Array {
            return _historyFragment;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            this._chatId = param1.readInteger();
            _historyFragment = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this._historyFragment.push(new class_1741(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
