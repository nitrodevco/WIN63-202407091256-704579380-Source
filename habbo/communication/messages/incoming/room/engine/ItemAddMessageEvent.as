package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1629

    [SecureSWF(rename="true")]
    public class ItemAddMessageEvent extends MessageEvent {

        public function ItemAddMessageEvent(param1: Function) {
            super(param1, class_1629);
        }

        public function getParser(): class_1629 {
            return _parser as class_1629;
        }
    }
}
