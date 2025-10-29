package com.sulake.habbo.communication.messages.incoming.sound {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.sound.class_1152

    [SecureSWF(rename="true")]
    public class TraxSongInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function TraxSongInfoMessageEvent(param1: Function) {
            super(param1, class_1152);
        }

        public function getParser(): class_1152 {
            return this._parser as class_1152;
        }
    }
}
