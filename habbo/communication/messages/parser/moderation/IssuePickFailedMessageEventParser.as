package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class IssuePickFailedMessageEventParser implements IMessageParser {

        public function IssuePickFailedMessageEventParser() {
            super();
        }
        private var var_314: Array;
        private var var_978: Boolean;
        private var var_897: int;

        public function get issues(): Array {
            return var_314;
        }

        public function get retryEnabled(): Boolean {
            return var_978;
        }

        public function get retryCount(): int {
            return var_897;
        }

        public function flush(): Boolean {
            var_314 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc7_: int = 0;
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            var _loc5_: String = null;
            var _loc4_: class_1722 = null;
            var_314 = [];
            var _loc6_: int = param1.readInteger();
            _loc7_ = 0;
            while (_loc7_ < _loc6_) {
                _loc3_ = param1.readInteger();
                _loc2_ = param1.readInteger();
                _loc5_ = param1.readString();
                _loc4_ = new class_1722(_loc3_, 0, 0, 0, 0, 0, 0, 0, null, 0, null, _loc2_, _loc5_, null, 0, []);
                var_314.push(_loc4_);
                _loc7_++;
            }
            var_978 = param1.readBoolean();
            var_897 = param1.readInteger();
            return true;
        }
    }
}
