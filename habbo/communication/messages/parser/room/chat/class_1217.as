package com.sulake.habbo.communication.messages.parser.room.chat {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1732

    [SecureSWF(rename="true")]
    public class class_1217 implements IMessageParser {

        public function class_1217() {
            super();
        }
        private var var_526: class_1732;

        public function get chatSettings(): class_1732 {
            return var_526;
        }

        public function flush(): Boolean {
            var_526 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_526 = new class_1732(param1);
            return true;
        }
    }
}
