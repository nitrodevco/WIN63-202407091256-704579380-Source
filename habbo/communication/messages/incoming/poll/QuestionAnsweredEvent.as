package com.sulake.habbo.communication.messages.incoming.poll {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.poll.class_1364

    [SecureSWF(rename="true")]
    public class QuestionAnsweredEvent extends MessageEvent implements IMessageEvent {

        public function QuestionAnsweredEvent(param1: Function) {
            super(param1, class_1364);
        }

        public function getParser(): class_1364 {
            return _parser as class_1364;
        }
    }
}
