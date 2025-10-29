package com.sulake.habbo.communication.messages.incoming.room.action {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.action.class_1620

    [SecureSWF(rename="true")]
    public class AvatarEffectMessageEvent extends MessageEvent {

        public function AvatarEffectMessageEvent(param1: Function) {
            super(param1, class_1620);
        }

        public function getParser(): class_1620 {
            return _parser as class_1620;
        }
    }
}
