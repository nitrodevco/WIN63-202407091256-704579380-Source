package com.sulake.habbo.communication.messages.incoming.poll {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.poll.class_1507

    [SecureSWF(rename="true")]
    public class class_922 extends MessageEvent implements IMessageEvent {

        public function class_922(param1: Function) {
            super(param1, class_1507);
        }

        public function getParser(): class_1507 {
            return _parser as class_1507;
        }
    }
}
