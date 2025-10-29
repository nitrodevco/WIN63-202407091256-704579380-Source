package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1570

    [SecureSWF(rename="true")]
    public class ItemsMessageEvent extends MessageEvent {

        public function ItemsMessageEvent(param1: Function) {
            super(param1, class_1570);
        }

        public function getParser(): class_1570 {
            return _parser as class_1570;
        }
    }
}
