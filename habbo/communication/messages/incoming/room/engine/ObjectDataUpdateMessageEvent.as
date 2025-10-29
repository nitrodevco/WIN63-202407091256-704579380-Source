package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1365

    [SecureSWF(rename="true")]
    public class ObjectDataUpdateMessageEvent extends MessageEvent {

        public function ObjectDataUpdateMessageEvent(param1: Function) {
            super(param1, class_1365);
        }

        public function getParser(): class_1365 {
            return _parser as class_1365;
        }
    }
}
