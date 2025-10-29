package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1138

    [SecureSWF(rename="true")]
    public class ModeratorUserInfoEvent extends MessageEvent implements IMessageEvent {

        public function ModeratorUserInfoEvent(param1: Function) {
            super(param1, class_1138);
        }

        public function getParser(): class_1138 {
            return _parser as class_1138;
        }
    }
}
