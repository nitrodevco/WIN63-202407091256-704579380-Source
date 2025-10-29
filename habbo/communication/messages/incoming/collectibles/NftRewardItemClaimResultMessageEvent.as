package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1521

    [SecureSWF(rename="true")]
    public class NftRewardItemClaimResultMessageEvent extends MessageEvent implements IMessageEvent {

        public function NftRewardItemClaimResultMessageEvent(param1: Function) {
            super(param1, class_1521);
        }

        public function getParser(): class_1521 {
            return _parser as class_1521;
        }
    }
}
