package com.sulake.habbo.communication.messages.incoming.nux {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.nux.class_1475

    [SecureSWF(rename="true")]
    public class SelectInitialRoomEvent extends MessageEvent implements IMessageEvent {

        public function SelectInitialRoomEvent(param1: Function) {
            super(param1, class_1475);
        }

        public function getParser(): class_1475 {
            return _parser as class_1475;
        }
    }
}
