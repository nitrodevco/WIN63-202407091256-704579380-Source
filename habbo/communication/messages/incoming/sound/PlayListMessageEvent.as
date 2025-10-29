package com.sulake.habbo.communication.messages.incoming.sound {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.sound.class_1387

    [SecureSWF(rename="true")]
    public class PlayListMessageEvent extends MessageEvent implements IMessageEvent {

        public function PlayListMessageEvent(param1: Function) {
            super(param1, class_1387);
        }

        public function getParser(): class_1387 {
            return this._parser as class_1387;
        }
    }
}
