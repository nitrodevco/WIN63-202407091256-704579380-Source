package com.sulake.habbo.communication.messages.incoming.crafting {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.crafting.class_1454

    [SecureSWF(rename="true")]
    public class CraftingRecipeMessageEvent extends MessageEvent implements IMessageEvent {

        public function CraftingRecipeMessageEvent(param1: Function) {
            super(param1, class_1454);
        }

        public function getParser(): class_1454 {
            return _parser as class_1454;
        }
    }
}
