package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1407

    [SecureSWF(rename="true")]
    public class Game2StageStartingMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2StageStartingMessageEvent(param1: Function) {
            super(param1, class_1407);
        }

        public function getParser(): class_1407 {
            return this._parser as class_1407;
        }
    }
}
