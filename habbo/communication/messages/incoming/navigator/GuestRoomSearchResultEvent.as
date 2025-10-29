package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1352

    [SecureSWF(rename="true")]
    public class GuestRoomSearchResultEvent extends MessageEvent implements IMessageEvent {

        public function GuestRoomSearchResultEvent(param1: Function) {
            super(param1, class_1352);
        }

        public function getParser(): class_1352 {
            return this._parser as class_1352;
        }
    }
}
