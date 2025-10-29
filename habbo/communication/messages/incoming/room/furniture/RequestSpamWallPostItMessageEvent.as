package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1279

    [SecureSWF(rename="true")]
    public class RequestSpamWallPostItMessageEvent extends MessageEvent implements IMessageEvent {

        public function RequestSpamWallPostItMessageEvent(param1: Function) {
            super(param1, class_1279);
        }

        public function getParser(): class_1279 {
            return _parser as class_1279;
        }
    }
}
