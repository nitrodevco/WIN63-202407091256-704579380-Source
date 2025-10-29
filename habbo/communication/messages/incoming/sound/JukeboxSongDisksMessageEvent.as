package com.sulake.habbo.communication.messages.incoming.sound {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.sound.class_1400

    [SecureSWF(rename="true")]
    public class JukeboxSongDisksMessageEvent extends MessageEvent implements IMessageEvent {

        public function JukeboxSongDisksMessageEvent(param1: Function) {
            super(param1, class_1400);
        }

        public function getParser(): class_1400 {
            return this._parser as class_1400;
        }
    }
}
