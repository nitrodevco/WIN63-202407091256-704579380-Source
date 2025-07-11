package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1505

    [SecureSWF(rename="true")]
    public class class_523 extends MessageEvent implements IMessageEvent {

        public function class_523(param1: Function) {
            super(param1, class_1505);
        }

        public function getParser(): class_1505 {
            return _parser as class_1505;
        }
    }
}
