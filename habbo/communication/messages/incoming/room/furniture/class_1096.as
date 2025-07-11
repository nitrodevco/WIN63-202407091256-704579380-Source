package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1596

    [SecureSWF(rename="true")]
    public class class_1096 extends MessageEvent {

        public function class_1096(param1: Function) {
            super(param1, class_1596);
        }

        public function getParser(): class_1596 {
            return parser as class_1596;
        }
    }
}
