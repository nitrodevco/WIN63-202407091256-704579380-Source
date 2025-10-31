package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1715

    [SecureSWF(rename="true")]
    public class SeasonalQuestsMessageEventParser implements IMessageParser {

        public function SeasonalQuestsMessageEventParser() {
            super();
        }
        private var var_692: Array;

        public function get quests(): Array {
            return var_692;
        }

        public function flush(): Boolean {
            var_692 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_692.push(new class_1715(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
