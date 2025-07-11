package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_1712

    [SecureSWF(rename="true")]
    public class HabboSearchResultMessageParser implements IMessageParser {

        public function HabboSearchResultMessageParser() {
            super();
        }
        private var var_1471: Array;

        private var _others: Array;

        public function get others(): Array {
            return this._others;
        }

        public function get friends(): Array {
            return this.var_1471;
        }

        public function flush(): Boolean {
            this.var_1471 = [];
            this._others = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.var_1471.push(new class_1712(param1));
                _loc3_++;
            }
            var _loc4_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc4_) {
                this._others.push(new class_1712(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
