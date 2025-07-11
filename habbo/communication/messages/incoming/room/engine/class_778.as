package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1526

    [SecureSWF(rename="true")]
    public class class_778 extends MessageEvent implements IMessageEvent {

        public function class_778(param1: Function) {
            super(param1, class_1526);
        }

        public function getParser(): class_1526 {
            return _parser as class_1526;
        }
    }
}
