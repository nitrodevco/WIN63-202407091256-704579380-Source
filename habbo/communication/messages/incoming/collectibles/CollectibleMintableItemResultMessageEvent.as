package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1172

    [SecureSWF(rename="true")]
    public class CollectibleMintableItemResultMessageEvent extends MessageEvent implements IMessageEvent {

        public function CollectibleMintableItemResultMessageEvent(param1: Function) {
            super(param1, class_1172);
        }

        public function getParser(): class_1172 {
            return _parser as class_1172;
        }
    }
}
