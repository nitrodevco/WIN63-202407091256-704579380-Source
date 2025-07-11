package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1373

    [SecureSWF(rename="true")]
    public class class_1367 implements IMessageParser {

        public function class_1367() {
            super();
        }
        private var var_509: class_1373;
        private var var_825: Boolean;
        private var var_395: String;

        public function get root(): class_1373 {
            return var_509;
        }

        public function get newAdditionsAvailable(): Boolean {
            return var_825;
        }

        public function get catalogType(): String {
            return var_395;
        }

        public function flush(): Boolean {
            var_509 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_509 = new class_1373(param1);
            var_825 = param1.readBoolean();
            var_395 = param1.readString();
            return true;
        }
    }
}
