package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1333

    [SecureSWF(rename="true")]
    public class UsersMessageEvent extends MessageEvent implements IMessageEvent {

        public function UsersMessageEvent(param1: Function) {
            super(param1, class_1333);
        }

        public function getParser(): class_1333 {
            return _parser as class_1333;
        }
    }
}
