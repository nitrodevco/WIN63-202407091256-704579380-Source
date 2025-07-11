package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1434

    [SecureSWF(rename="true")]
    public class class_267 extends MessageEvent implements IMessageEvent {

        public function class_267(param1: Function) {
            super(param1, class_1434);
        }

        public function get messageText(): String {
            return (_parser as class_1434).messageText;
        }

        public function getParser(): class_1434 {
            return _parser as class_1434;
        }
    }
}
