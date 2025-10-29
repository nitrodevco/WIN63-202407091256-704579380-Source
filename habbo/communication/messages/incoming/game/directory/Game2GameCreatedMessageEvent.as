package com.sulake.habbo.communication.messages.incoming.game.directory {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.directory.class_1589

    [SecureSWF(rename="true")]
    public class Game2GameCreatedMessageEvent extends MessageEvent implements IMessageEvent {

        public function Game2GameCreatedMessageEvent(param1: Function) {
            super(param1, class_1589);
        }

        public function getParser(): class_1589 {
            return this._parser as class_1589;
        }
    }
}
