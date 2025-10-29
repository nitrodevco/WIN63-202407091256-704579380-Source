package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1497

    [SecureSWF(rename="true")]
    public class Game2StageEndingMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2StageEndingMessageEvent(param1: Function) {
            super(param1, class_1497);
        }

        public function getParser(): class_1497 {
            return this._parser as class_1497;
        }
    }
}
