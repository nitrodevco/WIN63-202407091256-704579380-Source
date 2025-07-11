package com.sulake.habbo.communication.messages.incoming.room.action {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.action.class_1625

    [SecureSWF(rename="true")]
    public class class_994 extends MessageEvent implements IMessageEvent {

        public function class_994(param1: Function) {
            super(param1, class_1625);
        }

        public function getParser(): class_1625 {
            return _parser as class_1625;
        }
    }
}
