package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1117

    [SecureSWF(rename="true")]
    public class class_314 extends MessageEvent implements IMessageEvent {

        public function class_314(param1: Function) {
            super(param1, class_1117);
        }

        public function getParser(): class_1117 {
            return this._parser as class_1117;
        }
    }
}
