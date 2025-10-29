package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1143

    [SecureSWF(rename="true")]
    public class CommunityGoalProgressMessageEvent extends MessageEvent implements IMessageEvent {

        public function CommunityGoalProgressMessageEvent(param1: Function) {
            super(param1, class_1143);
        }

        public function getParser(): class_1143 {
            return _parser as class_1143;
        }
    }
}
