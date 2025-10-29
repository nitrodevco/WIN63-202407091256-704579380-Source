package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1280

    [SecureSWF(rename="true")]
    public class ObjectRemoveMessageEvent extends MessageEvent {

        public function ObjectRemoveMessageEvent(param1: Function) {
            super(param1, class_1280);
        }

        public function getParser(): class_1280 {
            return _parser as class_1280;
        }
    }
}
