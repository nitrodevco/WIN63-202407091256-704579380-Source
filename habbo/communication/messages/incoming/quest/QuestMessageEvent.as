package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1231

    [SecureSWF(rename="true")]
    public class QuestMessageEvent extends MessageEvent implements IMessageEvent {

        public function QuestMessageEvent(param1: Function) {
            super(param1, class_1231);
        }

        public function getParser(): class_1231 {
            return _parser as class_1231;
        }
    }
}
