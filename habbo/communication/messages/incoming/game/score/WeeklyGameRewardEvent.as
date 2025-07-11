package com.sulake.habbo.communication.messages.incoming.game.score {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.score.class_1466

    public class WeeklyGameRewardEvent extends MessageEvent {

        public function WeeklyGameRewardEvent(param1: Function) {
            super(param1, class_1466);
        }

        public function getParser(): class_1466 {
            return this._parser as class_1466;
        }
    }
}
