package com.sulake.habbo.communication.messages.incoming.inventory.clothing {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.clothing.class_1473

    [SecureSWF(rename="true")]
    public class FigureSetIdsEvent extends MessageEvent implements IMessageEvent {

        public function FigureSetIdsEvent(param1: Function) {
            super(param1, class_1473);
        }

        public function getParser(): class_1473 {
            return _parser as class_1473;
        }
    }
}
