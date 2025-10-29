package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1624

    [SecureSWF(rename="true")]
    public class ObjectRemoveConfirmMessageEvent extends MessageEvent {

        public function ObjectRemoveConfirmMessageEvent(param1: Function) {
            super(param1, class_1624);
        }

        public function getParser(): class_1624 {
            return _parser as class_1624;
        }
    }
}
