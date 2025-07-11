package com.sulake.habbo.communication.messages.incoming.game.lobby {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.lobby.class_1506

    [SecureSWF(rename="true")]
    public class class_894 extends MessageEvent implements IMessageEvent {

        public function class_894(param1: Function) {
            super(param1, class_1506);
        }

        public function getParser(): class_1506 {
            return this._parser as class_1506;
        }
    }
}
