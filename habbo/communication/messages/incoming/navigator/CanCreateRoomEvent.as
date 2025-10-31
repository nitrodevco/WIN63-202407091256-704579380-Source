package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventParser

    [SecureSWF(rename="true")]
    public class CanCreateRoomEvent extends MessageEvent implements IMessageEvent {

        public function CanCreateRoomEvent(param1: Function) {
            super(param1, CanCreateRoomEventParser);
        }

        public function getParser(): CanCreateRoomEventParser {
            return this._parser as CanCreateRoomEventParser;
        }
    }
}
