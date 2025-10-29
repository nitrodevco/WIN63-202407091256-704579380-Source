package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1368

    [SecureSWF(rename="true")]
    public class OfficialRoomsEvent extends MessageEvent implements IMessageEvent {

        public function OfficialRoomsEvent(param1: Function) {
            super(param1, class_1368);
        }

        public function getParser(): class_1368 {
            return this._parser as class_1368;
        }
    }
}
