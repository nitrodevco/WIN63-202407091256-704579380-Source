package com.sulake.habbo.communication.messages.parser.room.permissions {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class YouAreControllerMessageEventParser implements IMessageParser {

        public function YouAreControllerMessageEventParser() {
            super();
        }
        private var var_1518: int = 0;

        private var _flatId: int = 0;

        public function get flatId(): int {
            return _flatId;
        }

        public function get roomControllerLevel(): int {
            return var_1518;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            this._flatId = param1.readInteger();
            this.var_1518 = param1.readInteger();
            return true;
        }
    }
}
