package com.sulake.habbo.communication.messages.incoming.room.permissions {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.permissions.class_1202

    [SecureSWF(rename="true")]
    public class class_702 extends MessageEvent {

        public function class_702(param1: Function) {
            super(param1, class_1202);
        }

        public function getParser(): class_1202 {
            return _parser as class_1202;
        }
    }
}
