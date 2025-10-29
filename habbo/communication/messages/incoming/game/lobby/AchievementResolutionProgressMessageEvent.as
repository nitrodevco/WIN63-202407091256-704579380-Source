package com.sulake.habbo.communication.messages.incoming.game.lobby {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.lobby.class_1622

    [SecureSWF(rename="true")]
    public class AchievementResolutionProgressMessageEvent extends MessageEvent implements IMessageEvent {

        public function AchievementResolutionProgressMessageEvent(param1: Function) {
            super(param1, class_1622);
        }

        public function getParser(): class_1622 {
            return this._parser as class_1622;
        }
    }
}
