package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1467

    [SecureSWF(rename="true")]
    public class InClientLinkMessageEvent extends MessageEvent implements IMessageEvent {

        public function InClientLinkMessageEvent(param1: Function) {
            super(param1, class_1467);
        }

        public function get link(): String {
            return (_parser as class_1467).link;
        }
    }
}
