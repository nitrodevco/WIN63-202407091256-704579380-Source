package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1157

    [SecureSWF(rename="true")]
    public class RoomEventEvent extends MessageEvent implements IMessageEvent {

        public function RoomEventEvent(param1: Function) {
            super(param1, class_1157);
        }

        public function getParser(): class_1157 {
            return this._parser as class_1157;
        }
    }
}
