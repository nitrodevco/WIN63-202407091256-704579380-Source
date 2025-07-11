package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1401

    [SecureSWF(rename="true")]
    public class class_1055 extends MessageEvent implements IMessageEvent {

        public function class_1055(param1: Function) {
            super(param1, class_1401);
        }

        public function getParser(): class_1401 {
            return this._parser as class_1401;
        }
    }
}
