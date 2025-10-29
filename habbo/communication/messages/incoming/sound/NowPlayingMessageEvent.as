package com.sulake.habbo.communication.messages.incoming.sound {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.sound.class_1379

    [SecureSWF(rename="true")]
    public class NowPlayingMessageEvent extends MessageEvent implements IMessageEvent {

        public function NowPlayingMessageEvent(param1: Function) {
            super(param1, class_1379);
        }

        public function getParser(): class_1379 {
            return this._parser as class_1379;
        }
    }
}
