package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1465

    [SecureSWF(rename="true")]
    public class ItemStateUpdateMessageEvent extends MessageEvent {

        public function ItemStateUpdateMessageEvent(param1: Function) {
            super(param1, class_1465);
        }

        public function getParser(): class_1465 {
            return _parser as class_1465;
        }
    }
}
