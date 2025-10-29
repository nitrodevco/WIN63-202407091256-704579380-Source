package com.sulake.habbo.communication.messages.incoming.nft {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.nft.class_1216

    [SecureSWF(rename="true")]
    public class UserNftWardrobeSelectionMessageEvent extends MessageEvent implements IMessageEvent {

        public function UserNftWardrobeSelectionMessageEvent(param1: Function) {
            super(param1, class_1216);
        }

        public function getParser(): class_1216 {
            return _parser as class_1216;
        }
    }
}
