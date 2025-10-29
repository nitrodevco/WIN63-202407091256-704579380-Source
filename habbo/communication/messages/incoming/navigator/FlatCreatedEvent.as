package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1616

    [SecureSWF(rename="true")]
    public class FlatCreatedEvent extends MessageEvent implements IMessageEvent {

        public function FlatCreatedEvent(param1: Function) {
            super(param1, class_1616);
        }

        public function getParser(): class_1616 {
            return this._parser as class_1616;
        }
    }
}
