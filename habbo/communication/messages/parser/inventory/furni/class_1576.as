package com.sulake.habbo.communication.messages.parser.inventory.furni {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1576 implements IMessageParser {

        public function class_1576() {
            super();
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            return true;
        }

        public function flush(): Boolean {
            return true;
        }
    }
}
