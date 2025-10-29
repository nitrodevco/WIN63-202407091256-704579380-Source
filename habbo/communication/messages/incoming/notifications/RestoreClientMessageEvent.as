package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1332

    [SecureSWF(rename="true")]
    public class RestoreClientMessageEvent extends MessageEvent implements IMessageEvent {

        public function RestoreClientMessageEvent(param1: Function) {
            super(param1, class_1332);
        }

        public function getParser(): class_1332 {
            return _parser as class_1332;
        }
    }
}
