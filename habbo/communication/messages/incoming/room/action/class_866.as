package com.sulake.habbo.communication.messages.incoming.room.action {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.action.class_1175

    [SecureSWF(rename="true")]
    public class class_866 extends MessageEvent {

        public function class_866(param1: Function) {
            super(param1, class_1175);
        }

        public function getParser(): class_1175 {
            return _parser as class_1175;
        }
    }
}
