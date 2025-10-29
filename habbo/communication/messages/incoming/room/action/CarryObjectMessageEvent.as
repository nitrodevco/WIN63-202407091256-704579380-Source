package com.sulake.habbo.communication.messages.incoming.room.action {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.action.class_1292

    [SecureSWF(rename="true")]
    public class CarryObjectMessageEvent extends MessageEvent implements IMessageEvent {

        public function CarryObjectMessageEvent(param1: Function) {
            super(param1, class_1292);
        }

        public function getParser(): class_1292 {
            return _parser as class_1292;
        }
    }
}
