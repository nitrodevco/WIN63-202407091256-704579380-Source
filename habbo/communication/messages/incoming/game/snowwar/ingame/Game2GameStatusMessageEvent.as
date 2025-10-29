package com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.class_1554

    [SecureSWF(rename="true")]
    public class Game2GameStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2GameStatusMessageEvent(param1: Function) {
            super(param1, class_1554);
        }

        public function getParser(): class_1554 {
            return this._parser as class_1554;
        }
    }
}
