package com.sulake.habbo.communication.messages.incoming.crafting {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.crafting.class_1353

    [SecureSWF(rename="true")]
    public class CraftableProductsMessageEvent extends MessageEvent implements IMessageEvent {

        public function CraftableProductsMessageEvent(param1: Function) {
            super(param1, class_1353);
        }

        public function getParser(): class_1353 {
            return _parser as class_1353;
        }
    }
}
