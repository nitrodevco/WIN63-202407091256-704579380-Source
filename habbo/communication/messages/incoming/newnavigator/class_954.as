package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.newnavigator.class_1590

    [SecureSWF(rename="true")]
    public class class_954 extends MessageEvent {

        public function class_954(param1: Function) {
            super(param1, class_1590);
        }

        public function getParser(): class_1590 {
            return parser as class_1590;
        }
    }
}
