package com.sulake.habbo.communication.messages.incoming.poll {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.poll.class_1276

    [SecureSWF(rename="true")]
    public class QuestionFinishedEvent extends MessageEvent implements IMessageEvent {

        public function QuestionFinishedEvent(param1: Function) {
            super(param1, class_1276);
        }

        public function getParser(): class_1276 {
            return _parser as class_1276;
        }
    }
}
