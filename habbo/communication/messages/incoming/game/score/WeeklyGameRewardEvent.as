package com.sulake.habbo.communication.messages.incoming.game.score {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.score.WeeklyGameRewardEventParser

    public class WeeklyGameRewardEvent extends MessageEvent {

        public function WeeklyGameRewardEvent(param1: Function) {
            super(param1, WeeklyGameRewardEventParser);
        }

        public function getParser(): WeeklyGameRewardEventParser {
            return this._parser as WeeklyGameRewardEventParser;
        }
    }
}
