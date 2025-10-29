package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1227

    [SecureSWF(rename="true")]
    public class ItemsStateUpdateMessageEvent extends MessageEvent {

        public function ItemsStateUpdateMessageEvent(param1: Function) {
            super(param1, class_1227);
        }

        public function getParser(): class_1227 {
            return _parser as class_1227;
        }
    }
}
