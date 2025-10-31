package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ModeratorInitMessageEventParser implements IMessageParser {

        public function ModeratorInitMessageEventParser() {
            super();
        }
        private var var_47: class_1762;

        public function get data(): class_1762 {
            return var_47;
        }

        public function flush(): Boolean {
            if (var_47 != null) {
                var_47.dispose();
                var_47 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1762(param1);
            return true;
        }
    }
}
