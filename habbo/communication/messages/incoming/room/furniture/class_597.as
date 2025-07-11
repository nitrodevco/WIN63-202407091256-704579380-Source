package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1301

    [SecureSWF(rename="true")]
    public class class_597 extends MessageEvent {

        public function class_597(param1: Function) {
            super(param1, class_1301);
        }

        public function getParser(): class_1301 {
            return parser as class_1301;
        }
    }
}
