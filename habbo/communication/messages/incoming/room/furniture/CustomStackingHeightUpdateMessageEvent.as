package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1331

    [SecureSWF(rename="true")]
    public class CustomStackingHeightUpdateMessageEvent extends MessageEvent implements IMessageEvent {

        public function CustomStackingHeightUpdateMessageEvent(param1: Function) {
            super(param1, class_1331);
        }

        public function getParser(): class_1331 {
            return _parser as class_1331;
        }
    }
}
