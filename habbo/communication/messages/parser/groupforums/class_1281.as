package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1281 implements IMessageParser {

        public function class_1281() {
            super();
        }
        private var var_441: class_1740;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        public function get thread(): class_1740 {
            return var_441;
        }

        public function flush(): Boolean {
            _groupId = -1;
            var_441 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _groupId = param1.readInteger();
            var_441 = class_1740.readFromMessage(param1);
            return true;
        }
    }
}
