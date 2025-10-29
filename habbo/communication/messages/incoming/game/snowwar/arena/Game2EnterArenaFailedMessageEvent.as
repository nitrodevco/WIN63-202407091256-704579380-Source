package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1573

    [SecureSWF(rename="true")]
    public class Game2EnterArenaFailedMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2EnterArenaFailedMessageEvent(param1: Function) {
            super(param1, class_1573);
        }

        public function getParser(): class_1573 {
            return this._parser as class_1573;
        }
    }
}
