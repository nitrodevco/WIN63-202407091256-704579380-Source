package com.sulake.habbo.communication.messages.parser.callforhelp {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1744

    [SecureSWF(rename="true")]
    public class class_1223 implements IMessageParser {

        public function class_1223() {
            super();
        }
        private var var_546: int = -1;
        private var var_388: int = -1;
        private var var_428: class_1744;

        public function get issueId(): int {
            return var_546;
        }

        public function get accountId(): int {
            return var_388;
        }

        public function get sanctionType(): class_1744 {
            return var_428;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_546 = param1.readInteger();
            var_388 = param1.readInteger();
            var_428 = new class_1744(param1);
            return true;
        }

        public function flush(): Boolean {
            var_546 = -1;
            var_388 = -1;
            var_428 = null;
            return true;
        }
    }
}
