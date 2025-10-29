package com.sulake.habbo.communication.messages.incoming.sound {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.sound.class_1498

    [SecureSWF(rename="true")]
    public class OfficialSongIdMessageEvent extends MessageEvent implements IMessageEvent {

        public function OfficialSongIdMessageEvent(param1: Function) {
            super(param1, class_1498);
        }

        public function getParser(): class_1498 {
            return this._parser as class_1498;
        }
    }
}
