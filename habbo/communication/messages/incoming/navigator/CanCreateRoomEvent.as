package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1483

    [SecureSWF(rename="true")]
    public class CanCreateRoomEvent extends MessageEvent implements IMessageEvent {

        public function CanCreateRoomEvent(param1: Function) {
            super(param1, class_1483);
        }

        public function getParser(): class_1483 {
            return this._parser as class_1483;
        }
    }
}
