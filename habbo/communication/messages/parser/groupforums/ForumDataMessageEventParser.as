package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ForumDataMessageEventParser implements IMessageParser {

        public function ForumDataMessageEventParser() {
            super();
        }
        private var var_513: class_1755;

        public function get forumData(): class_1755 {
            return var_513;
        }

        public function flush(): Boolean {
            var_513 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_513 = class_1755.readFromMessage(param1);
            return true;
        }
    }
}
