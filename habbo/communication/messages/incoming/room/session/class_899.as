package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1207

    [SecureSWF(rename="true")]
    public class class_899 extends MessageEvent implements IMessageEvent {

        public function class_899(param1: Function) {
            super(param1, class_1207);
        }

        public function getParser(): class_1207 {
            return _parser as class_1207;
        }
    }
}
