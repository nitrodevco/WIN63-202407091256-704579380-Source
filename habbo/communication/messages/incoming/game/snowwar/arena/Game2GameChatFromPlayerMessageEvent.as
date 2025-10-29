package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1382

    [SecureSWF(rename="true")]
    public class Game2GameChatFromPlayerMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2GameChatFromPlayerMessageEvent(param1: Function) {
            super(param1, class_1382);
        }

        public function getParser(): class_1382 {
            return this._parser as class_1382;
        }
    }
}
