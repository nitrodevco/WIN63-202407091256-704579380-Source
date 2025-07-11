package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.newnavigator.class_1323

    [SecureSWF(rename="true")]
    public class class_364 extends MessageEvent {

        public function class_364(param1: Function) {
            super(param1, class_1323);
        }

        public function getParser(): class_1323 {
            return parser as class_1323;
        }
    }
}
