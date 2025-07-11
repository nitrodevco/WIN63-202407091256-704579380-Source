package com.sulake.habbo.communication.messages.incoming.landingview.votes {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.landingview.votes.class_1443

    [SecureSWF(rename="true")]
    public class class_860 extends MessageEvent {

        public function class_860(param1: Function) {
            super(param1, class_1443);
        }

        public function getParser(): class_1443 {
            return _parser as class_1443;
        }
    }
}
