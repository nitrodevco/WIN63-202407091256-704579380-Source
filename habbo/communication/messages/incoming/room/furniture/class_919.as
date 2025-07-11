package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1383

    [SecureSWF(rename="true")]
    public class class_919 extends MessageEvent {

        public function class_919(param1: Function) {
            super(param1, class_1383);
        }

        public function getParser(): class_1383 {
            return parser as class_1383;
        }
    }
}
