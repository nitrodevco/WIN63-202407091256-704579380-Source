package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1734

    [SecureSWF(rename="true")]
    public class class_1399 implements IMessageParser {

        public function class_1399() {
            super();
        }
        private var var_47: class_1734;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        public function get data(): class_1734 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this._flatId = param1.readInteger();
            this.var_47 = new class_1734(param1);
            return true;
        }
    }
}
