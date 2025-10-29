package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1412

    [SecureSWF(rename="true")]
    public class HeightMapMessageEvent extends MessageEvent {

        public function HeightMapMessageEvent(param1: Function) {
            super(param1, class_1412);
        }

        public function getParser(): class_1412 {
            return _parser as class_1412;
        }
    }
}
