package com.sulake.habbo.communication.messages.incoming.competition {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.competition.class_1545

    [SecureSWF(rename="true")]
    public class class_581 extends MessageEvent implements IMessageEvent {

        public function class_581(param1: Function) {
            super(param1, class_1545);
        }

        public function getParser(): class_1545 {
            return _parser as class_1545;
        }
    }
}
