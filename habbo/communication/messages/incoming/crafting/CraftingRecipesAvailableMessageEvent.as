package com.sulake.habbo.communication.messages.incoming.crafting {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.crafting.class_1155

    [SecureSWF(rename="true")]
    public class CraftingRecipesAvailableMessageEvent extends MessageEvent implements IMessageEvent {

        public function CraftingRecipesAvailableMessageEvent(param1: Function) {
            super(param1, class_1155);
        }

        public function getParser(): class_1155 {
            return _parser as class_1155;
        }
    }
}
