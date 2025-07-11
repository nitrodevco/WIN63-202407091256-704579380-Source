package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1249

    [SecureSWF(rename="true")]
    public class class_1080 extends MessageEvent implements IMessageEvent {

        public function class_1080(param1: Function) {
            super(param1, class_1249);
        }

        public function getParser(): class_1249 {
            return _parser as class_1249;
        }
    }
}
