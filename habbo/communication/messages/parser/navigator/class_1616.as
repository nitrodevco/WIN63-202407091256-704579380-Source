package com.sulake.habbo.communication.messages.parser.navigator {
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1616 implements IMessageParser {

        public function class_1616() {
            super();
        }
        private var var_1173: String;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function get flatName(): String {
            return var_1173;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._flatId = param1.readInteger();
            this.var_1173 = param1.readString();
            class_14.log("FLAT CREATED: " + this._flatId + ", " + this.var_1173);
            return true;
        }
    }
}
