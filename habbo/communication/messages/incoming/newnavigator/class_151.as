package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.newnavigator.class_1337

    [SecureSWF(rename="true")]
    public class class_151 extends MessageEvent {

        public function class_151(param1: Function) {
            super(param1, class_1337);
        }

        public function getParser(): class_1337 {
            return parser as class_1337;
        }
    }
}
