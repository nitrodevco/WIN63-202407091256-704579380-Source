package com.sulake.habbo.communication.messages.parser.campaign {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1499 implements IMessageParser {

        public function class_1499() {
            super();
        }
        private var var_47: class_1641;

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1641();
            var_47.parse(param1);
            return true;
        }

        public function flush(): Boolean {
            var_47 = null;
            return true;
        }

        public function cloneData(): class_1641 {
            return !!var_47 ? var_47.clone() : null;
        }
    }
}
