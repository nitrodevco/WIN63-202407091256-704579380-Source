package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.class_1256

    [SecureSWF(rename="true")]
    public class class_247 extends MessageEvent {

        public function class_247(param1: Function) {
            super(param1, class_1256);
        }

        public function getParser(): class_1256 {
            return _parser as class_1256;
        }
    }
}
