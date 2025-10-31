package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1757

    [SecureSWF(rename="true")]
    public class RoomChatlogEventParser implements IMessageParser {

        public function RoomChatlogEventParser() {
            super();
        }
        private var var_47: class_1757;

        public function get data(): class_1757 {
            return var_47;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_47 = new class_1757(param1);
            return true;
        }
    }
}
