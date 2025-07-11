package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.class_1146

    [SecureSWF(rename="true")]
    public class class_327 extends MessageEvent {

        public function class_327(param1: Function) {
            super(param1, class_1146);
        }

        public function getParser(): class_1146 {
            return _parser as class_1146;
        }
    }
}
