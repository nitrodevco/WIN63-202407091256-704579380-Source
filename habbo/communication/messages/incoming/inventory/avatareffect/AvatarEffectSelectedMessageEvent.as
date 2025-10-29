package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.class_1552

    [SecureSWF(rename="true")]
    public class AvatarEffectSelectedMessageEvent extends MessageEvent {

        public function AvatarEffectSelectedMessageEvent(param1: Function) {
            super(param1, class_1552);
        }

        public function getParser(): class_1552 {
            return _parser as class_1552;
        }
    }
}
