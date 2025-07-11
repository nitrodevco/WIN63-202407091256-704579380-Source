package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1584

    [SecureSWF(rename="true")]
    public class class_644 extends MessageEvent implements IMessageEvent {

        public function class_644(param1: Function) {
            super(param1, class_1584);
        }

        public function getParser(): class_1584 {
            return _parser as class_1584;
        }
    }
}
