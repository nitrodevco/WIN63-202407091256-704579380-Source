package com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.class_1531

    [SecureSWF(rename="true")]
    public class Game2FullGameStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2FullGameStatusMessageEvent(param1: Function) {
            super(param1, class_1531);
        }

        public function getParser(): class_1531 {
            return this._parser as class_1531;
        }
    }
}
