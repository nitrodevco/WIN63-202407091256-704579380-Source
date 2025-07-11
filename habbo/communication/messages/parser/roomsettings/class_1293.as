package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1293 implements IMessageParser {

        public function class_1293() {
            super();
        }
        private var var_418: int;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._flatId = param1.readInteger();
            this.var_418 = param1.readInteger();
            return true;
        }
    }
}
