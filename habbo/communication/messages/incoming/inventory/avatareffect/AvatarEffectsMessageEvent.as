package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageEventParser

    [SecureSWF(rename="true")]
    public class AvatarEffectsMessageEvent extends MessageEvent {

        public function AvatarEffectsMessageEvent(param1: Function) {
            super(param1, AvatarEffectsMessageEventParser);
        }

        public function getParser(): AvatarEffectsMessageEventParser {
            return _parser as AvatarEffectsMessageEventParser;
        }
    }
}
