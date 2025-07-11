package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1319

    [SecureSWF(rename="true")]
    public class class_148 extends MessageEvent {

        public function class_148(param1: Function) {
            super(param1, class_1319);
        }

        public function getParser(): class_1319 {
            return _parser as class_1319;
        }
    }
}
