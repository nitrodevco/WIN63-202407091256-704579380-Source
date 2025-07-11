package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1229

    [SecureSWF(rename="true")]
    public class class_688 extends MessageEvent implements IMessageEvent {

        public function class_688(param1: Function) {
            super(param1, class_1229);
        }

        public function getParser(): class_1229 {
            return parser as class_1229;
        }
    }
}
