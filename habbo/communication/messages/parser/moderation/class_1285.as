package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1285 implements IMessageParser {

        public function class_1285() {
            super();
        }
        private var var_546: int;

        public function get issueId(): int {
            return var_546;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_546 = parseInt(param1.readString());
            return true;
        }
    }
}
