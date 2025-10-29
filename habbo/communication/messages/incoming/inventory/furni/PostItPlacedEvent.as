package com.sulake.habbo.communication.messages.incoming.inventory.furni {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.furni.class_1228

    [SecureSWF(rename="true")]
    public class PostItPlacedEvent extends MessageEvent implements IMessageEvent {

        public function PostItPlacedEvent(param1: Function) {
            super(param1, class_1228);
        }

        public function getParser(): class_1228 {
            return this._parser as class_1228;
        }
    }
}
