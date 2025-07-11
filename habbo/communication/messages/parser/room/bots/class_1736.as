package com.sulake.habbo.communication.messages.parser.room.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1736 {

        public function class_1736(param1: IMessageDataWrapper) {
            super();
            parse(param1);
        }
        private var var_280: int;
        private var var_47: String;

        public function get id(): int {
            return var_280;
        }

        public function get data(): String {
            return var_47;
        }

        public function parse(param1: IMessageDataWrapper): void {
            var_280 = param1.readInteger();
            var_47 = param1.readString();
        }
    }
}
