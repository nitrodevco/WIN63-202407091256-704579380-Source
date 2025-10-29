package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1241

    [SecureSWF(rename="true")]
    public class Game2GameRejoinMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2GameRejoinMessageEvent(param1: Function) {
            super(param1, class_1241);
        }

        public function getParser(): class_1241 {
            return this._parser as class_1241;
        }
    }
}
