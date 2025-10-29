package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1414

    [SecureSWF(rename="true")]
    public class QuestCompletedMessageEvent extends MessageEvent implements IMessageEvent {

        public function QuestCompletedMessageEvent(param1: Function) {
            super(param1, class_1414);
        }

        public function getParser(): class_1414 {
            return _parser as class_1414;
        }
    }
}
