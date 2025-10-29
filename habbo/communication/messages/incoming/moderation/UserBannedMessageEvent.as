package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1303

    [SecureSWF(rename="true")]
    public class UserBannedMessageEvent extends MessageEvent implements IMessageEvent {

        public function UserBannedMessageEvent(param1: Function) {
            super(param1, class_1303);
        }

        public function getParser(): class_1303 {
            return _parser as class_1303;
        }
    }
}
