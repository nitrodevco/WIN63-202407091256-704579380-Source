package com.sulake.habbo.communication.messages.incoming.game.lobby {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.lobby.class_1572

    [SecureSWF(rename="true")]
    public class class_1012 extends MessageEvent implements IMessageEvent {

        public function class_1012(param1: Function) {
            super(param1, class_1572);
        }

        public function getParser(): class_1572 {
            return this._parser as class_1572;
        }
    }
}
