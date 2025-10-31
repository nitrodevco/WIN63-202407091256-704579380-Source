package com.sulake.habbo.communication.messages.incoming.sound {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageEventParser

    [SecureSWF(rename="true")]
    public class TraxSongInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function TraxSongInfoMessageEvent(param1: Function) {
            super(param1, TraxSongInfoMessageEventParser);
        }

        public function getParser(): TraxSongInfoMessageEventParser {
            return this._parser as TraxSongInfoMessageEventParser;
        }
    }
}
