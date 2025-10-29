package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1508

    [SecureSWF(rename="true")]
    public class DiceValueMessageEvent extends MessageEvent implements IMessageEvent {

        public function DiceValueMessageEvent(param1: Function) {
            super(param1, class_1508);
        }

        public function getParser(): class_1508 {
            return _parser as class_1508;
        }
    }
}
