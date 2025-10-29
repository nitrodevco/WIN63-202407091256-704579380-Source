package com.sulake.habbo.communication.messages.incoming.poll {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.poll.class_1200

    [SecureSWF(rename="true")]
    public class PollContentsEvent extends MessageEvent implements IMessageEvent {

        public function PollContentsEvent(param1: Function) {
            super(param1, class_1200);
        }

        public function getParser(): class_1200 {
            return _parser as class_1200;
        }
    }
}
