package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.newnavigator.class_1264

    [SecureSWF(rename="true")]
    public class class_713 extends MessageEvent {

        public function class_713(param1: Function) {
            super(param1, class_1264);
        }

        public function getParser(): class_1264 {
            return parser as class_1264;
        }
    }
}
