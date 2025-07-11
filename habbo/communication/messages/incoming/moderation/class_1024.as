package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.moderation.class_1287

    [SecureSWF(rename="true")]
    public class class_1024 extends MessageEvent implements IMessageEvent {

        public function class_1024(param1: Function) {
            super(param1, class_1287);
        }

        public function getParser(): class_1287 {
            return _parser as class_1287;
        }
    }
}
