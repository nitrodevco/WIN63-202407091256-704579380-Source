package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1166

    [SecureSWF(rename="true")]
    public class class_651 extends MessageEvent implements IMessageEvent {

        public function class_651(param1: Function) {
            super(param1, class_1166);
        }

        public function getParser(): class_1166 {
            return _parser as class_1166;
        }
    }
}
