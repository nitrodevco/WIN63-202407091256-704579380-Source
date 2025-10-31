package com.sulake.habbo.communication.messages.parser.camera {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CompetitionStatusMessageEventParser implements IMessageParser {

        public function CompetitionStatusMessageEventParser() {
            super();
        }
        private var var_344: Boolean = false;
        private var var_421: String = null;

        public function isOk(): Boolean {
            return var_344;
        }

        public function getErrorReason(): String {
            return var_421;
        }

        public function flush(): Boolean {
            var_344 = false;
            var_421 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_344 = param1.readBoolean();
            var_421 = param1.readString();
            return true;
        }
    }
}
