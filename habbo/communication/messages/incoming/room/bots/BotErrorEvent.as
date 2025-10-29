package com.sulake.habbo.communication.messages.incoming.room.bots {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.bots.class_1393

    [SecureSWF(rename="true")]
    public class BotErrorEvent extends MessageEvent implements IMessageEvent {

        public function BotErrorEvent(param1: Function) {
            super(param1, class_1393);
        }

        public function getParser(): class_1393 {
            return _parser as class_1393;
        }
    }
}
