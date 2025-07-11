package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.class_1128

    [SecureSWF(rename="true")]
    public class class_1108 extends MessageEvent {

        public function class_1108(param1: Function) {
            super(param1, class_1128);
        }

        public function getParser(): class_1128 {
            return _parser as class_1128;
        }
    }
}
