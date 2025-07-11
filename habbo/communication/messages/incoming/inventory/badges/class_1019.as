package com.sulake.habbo.communication.messages.incoming.inventory.badges {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.badges.class_1173

    [SecureSWF(rename="true")]
    public class class_1019 extends MessageEvent {

        public function class_1019(param1: Function) {
            super(param1, class_1173);
        }

        public function getParser(): class_1173 {
            return _parser as class_1173;
        }
    }
}
