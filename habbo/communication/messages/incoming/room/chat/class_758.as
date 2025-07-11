package com.sulake.habbo.communication.messages.incoming.room.chat {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1217

    [SecureSWF(rename="true")]
    public class class_758 extends MessageEvent {

        public function class_758(param1: Function) {
            super(param1, class_1217);
        }

        public function getParser(): class_1217 {
            return _parser as class_1217;
        }
    }
}
