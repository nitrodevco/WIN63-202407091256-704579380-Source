package com.sulake.habbo.communication.messages.incoming.nft {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.nft.class_1130

    [SecureSWF(rename="true")]
    public class UserNftChatStylesMessageEvent extends MessageEvent implements IMessageEvent {

        public function UserNftChatStylesMessageEvent(param1: Function) {
            super(param1, class_1130);
        }

        public function getParser(): class_1130 {
            return _parser as class_1130;
        }
    }
}
