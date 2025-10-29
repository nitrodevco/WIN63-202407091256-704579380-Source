package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1503

    [SecureSWF(rename="true")]
    public class ElementPointerMessageEvent extends MessageEvent implements IMessageEvent {

        public function ElementPointerMessageEvent(param1: Function) {
            super(param1, class_1503);
        }

        public function getParser(): class_1503 {
            return _parser as class_1503;
        }
    }
}
