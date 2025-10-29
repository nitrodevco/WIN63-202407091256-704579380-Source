package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1376

    [SecureSWF(rename="true")]
    public class ObjectUpdateMessageEvent extends MessageEvent {

        public function ObjectUpdateMessageEvent(param1: Function) {
            super(param1, class_1376);
        }

        public function getParser(): class_1376 {
            return _parser as class_1376;
        }
    }
}
