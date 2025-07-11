package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.newnavigator.class_1530

    [SecureSWF(rename="true")]
    public class class_348 extends MessageEvent {

        public function class_348(param1: Function) {
            super(param1, class_1530);
        }

        public function getParser(): class_1530 {
            return parser as class_1530;
        }
    }
}
