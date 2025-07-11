package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1169

    [SecureSWF(rename="true")]
    public class class_818 extends MessageEvent implements IMessageEvent {

        public function class_818(param1: Function) {
            super(param1, class_1169);
        }

        public function getParser(): class_1169 {
            return _parser as class_1169;
        }
    }
}
