package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1509

    [SecureSWF(rename="true")]
    public class CollectableMintableItemTypesMessageEvent extends MessageEvent implements IMessageEvent {

        public function CollectableMintableItemTypesMessageEvent(param1: Function) {
            super(param1, class_1509);
        }

        public function getParser(): class_1509 {
            return _parser as class_1509;
        }
    }
}
