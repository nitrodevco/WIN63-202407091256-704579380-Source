package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.ConvertedRoomIdEventParser

    [SecureSWF(rename="true")]
    public class ConvertedRoomIdEvent extends MessageEvent {

        public function ConvertedRoomIdEvent(param1: Function) {
            super(param1, ConvertedRoomIdEventParser);
        }

        public function get globalId(): String {
            return (this._parser as ConvertedRoomIdEventParser).globalId;
        }

        public function get convertedId(): int {
            return (this._parser as ConvertedRoomIdEventParser).convertedId;
        }

        public function getParser(): ConvertedRoomIdEventParser {
            return _parser as ConvertedRoomIdEventParser;
        }
    }
}
