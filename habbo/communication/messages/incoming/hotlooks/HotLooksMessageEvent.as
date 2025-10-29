package com.sulake.habbo.communication.messages.incoming.hotlooks {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.hotlooks.class_1519

    [SecureSWF(rename="true")]
    public class HotLooksMessageEvent extends MessageEvent implements IMessageEvent {

        public function HotLooksMessageEvent(param1: Function) {
            super(param1, class_1519);
        }

        public function getParser(): class_1519 {
            return _parser as class_1519;
        }
    }
}
