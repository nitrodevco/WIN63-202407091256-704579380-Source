package com.sulake.habbo.communication.messages.parser.landingview.votes {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class CommunityVoteReceivedEventParser implements IMessageParser {

        public function CommunityVoteReceivedEventParser() {
            super();
        }
        private var var_1151: Boolean;

        public function get acknowledged(): Boolean {
            return var_1151;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1151 = param1.readBoolean();
            return true;
        }
    }
}
