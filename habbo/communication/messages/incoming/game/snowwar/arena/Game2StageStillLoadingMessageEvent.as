package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1325

    [SecureSWF(rename="true")]
    public class Game2StageStillLoadingMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2StageStillLoadingMessageEvent(param1: Function) {
            super(param1, class_1325);
        }

        public function getParser(): class_1325 {
            return this._parser as class_1325;
        }
    }
}
