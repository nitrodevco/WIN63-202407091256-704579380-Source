package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1176

    [SecureSWF(rename="true")]
    public class ObjectAddMessageEvent extends MessageEvent {

        public function ObjectAddMessageEvent(param1: Function) {
            super(param1, class_1176);
        }

        public function getParser(): class_1176 {
            return _parser as class_1176;
        }
    }
}
