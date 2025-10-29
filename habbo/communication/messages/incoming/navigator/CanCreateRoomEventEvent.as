package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1349

    [SecureSWF(rename="true")]
    public class CanCreateRoomEventEvent extends MessageEvent implements IMessageEvent {

        public function CanCreateRoomEventEvent(param1: Function) {
            super(param1, class_1349);
        }

        public function getParser(): class_1349 {
            return this._parser as class_1349;
        }
    }
}
