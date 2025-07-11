package com.sulake.habbo.communication.messages.incoming.campaign {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.campaign.class_1115

    [SecureSWF(rename="true")]
    public class class_961 extends MessageEvent implements IMessageEvent {

        public function class_961(param1: Function) {
            super(param1, class_1115);
        }

        public function getParser(): class_1115 {
            return _parser as class_1115;
        }
    }
}
