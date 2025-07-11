package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1480

    [SecureSWF(rename="true")]
    public class class_903 extends MessageEvent implements IMessageEvent {

        public function class_903(param1: Function) {
            super(param1, class_1480);
        }

        public function getParser(): class_1480 {
            return this._parser as class_1480;
        }
    }
}
