package com.sulake.habbo.communication.messages.incoming.game.score {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.score.class_1583

    public class WeeklyGameRewardWinnersEvent extends MessageEvent {

        public function WeeklyGameRewardWinnersEvent(param1: Function) {
            super(param1, class_1583);
        }

        public function getParser(): class_1583 {
            return this._parser as class_1583;
        }
    }
}
