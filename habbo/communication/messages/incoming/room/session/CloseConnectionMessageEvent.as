package com.sulake.habbo.communication.messages.incoming.room.session {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.session.class_1219

    [SecureSWF(rename="true")]
    public class CloseConnectionMessageEvent extends MessageEvent implements IMessageEvent {

        public function CloseConnectionMessageEvent(param1: Function) {
            super(param1, class_1219);
        }

        public function getParser(): class_1219 {
            return _parser as class_1219;
        }
    }
}
