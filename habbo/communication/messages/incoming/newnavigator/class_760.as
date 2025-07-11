package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.newnavigator.class_1145

    [SecureSWF(rename="true")]
    public class class_760 extends MessageEvent {

        public function class_760(param1: Function) {
            super(param1, class_1145);
        }

        public function getParser(): class_1145 {
            return parser as class_1145;
        }
    }
}
