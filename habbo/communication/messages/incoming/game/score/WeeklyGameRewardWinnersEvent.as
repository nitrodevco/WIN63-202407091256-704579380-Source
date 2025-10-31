package com.sulake.habbo.communication.messages.incoming.game.score {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.score.WeeklyGameRewardWinnersEventParser

    public class WeeklyGameRewardWinnersEvent extends MessageEvent {

        public function WeeklyGameRewardWinnersEvent(param1: Function) {
            super(param1, WeeklyGameRewardWinnersEventParser);
        }

        public function getParser(): WeeklyGameRewardWinnersEventParser {
            return this._parser as WeeklyGameRewardWinnersEventParser;
        }
    }
}
